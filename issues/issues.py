#!/usr/bin/env python3

from os.path import join, dirname, isdir
from os import environ, mkdir
import sys
import argparse
from jinja2 import Template
from tabulate import tabulate

from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper


PARSER = argparse.ArgumentParser()
PARSER.add_argument("-r", "--repo", help="remote repository to create the issues at")
PARSER.add_argument("-l", "--lcs-labels", help="labels for regular LCS issues", nargs='*')
PARSER.add_argument("-i", "--isac-labels", help="labels for ISAC issues", nargs='*')
PARSER.add_argument("-m", "--milestone", help="milestone to assign all issues")
PARSER.add_argument("-t", "--tool", help="YAML file to customize the list and MWEs")
ARGS = PARSER.parse_args()

TPL_META = """
---
title: "[{{ lcs }}] {{ title }}"
labels: {{ labels }}
milestone: {{ milestone }}
---
"""

TPL = """
Ref [LCS page]({{ page }})

{{ body }}

# Minimal Working Example

{{ mwe }}
"""

ISSUES_DIR = join(dirname(__file__), '_issues')
GHR = None
EXISTING = {}


def issue_title(key, title):
    """
    Compose the title for an issue from the key and field 'title'
    """
    return "[%s] %s" % ("LCS" + key[4:] if key[0:4] == "ISAC" else key, title)


def configure(repo):
    """
    Get existing data from the repo or create a subdir to output markdown files
    """
    if repo:
        from github import Github
        GHR = Github(environ["GITHUB_TOKEN"]).get_repo(repo)

        titles = [issue_title(key, val["title"]) for key, val in DATA.items()]
        total = len(titles)
        # Traverse the list of existing issues in the repo once only
        # Compare the title against all the LCS titles that have not been found yet
        # If found, remove the title from the list, to optimize further iterations
        for issue in GHR.get_issues(state='all'):
            if issue.title in titles:
                EXISTING[issue.title] = issue
                titles.remove(issue.title)
        print("%d/%d issues exist already" % (total-len(titles), total))

        # PyGitHub requirest to pass a milestone object, not a string
        if ARGS.milestone:
            for mile in GHR.get_milestones():
                if mile.title == ARGS.milestone:
                    return mile
        #    TODO Create milestone
        return None
    elif not isdir(ISSUES_DIR):
        mkdir(ISSUES_DIR)


def get_data():
    """
    Get LCS data from a YAML file or from a hardcoded URL
    """
    try:
        with open(r'LCS2019.yml') as fptr:
            return load(fptr, Loader=Loader)
    except Exception:
        try:
            from urllib import request
            # FIXME Change the URL to branch 'master'
            return load(request.urlopen('https://raw.githubusercontent.com/VHDL/Compliance-Tests/LCS2019/issues/LCS2019.yml').read(), Loader=Loader)
        except Exception:
            pass
    print("ERROR: could not get LCS data!")
    sys.exit(1)


def check_key(obj, key, default):
    """
    Sanitize a field from an object
    """
    try:
        val = obj[key]
        if not val or len(val) == 0:
            val = default
    except KeyError:
        val = default
    return val


def process_tool(tool):
    """
    Read the configuration file for a tool, filter the items, and add MWE content
    """
    with open(tool) as fptr:
        TOOL = load(fptr, Loader=Loader)
        print("processing %d/%d items from '%s'" % (len(TOOL), len(DATA), ARGS.tool))
        for key in list(DATA.keys()):
            if key not in TOOL.keys():
                DISABLED[key] = DATA[key]
                del DATA[key]
            else:
                mwe = check_key(TOOL, key, "")
                if len(mwe) != 0:
                    DATA[key]["tool"] = "yes"
                    DATA[key]["mwe"] += ('\n' if len(check_key(DATA[key], "mwe", "")) != 0 else '') + mwe


def print_summary(data, disabled):
    """
    Print a summary of the available data and the issues to be created/updated
    """
    def data2tab(data, symbol):
        """
        Convert data dictionary into a list of lists
        """
        return [[
            symbol if check_key(val, "title", None) else " ",
            symbol if check_key(val, "page", None) else "a",
            symbol if check_key(val, "body", None) else " ",
            't' if check_key(val, "tool", None) else (symbol if check_key(val, "mwe", "") else " "),
            key
        ] for key, val in data.items()]

    print(tabulate(
        data2tab(data, "x") + data2tab(disabled, "-"),
        headers=["Title", "Page", "Body", "MWE", "ID"]
    ))


def write_md(tpl, key, title, milestone, item):
    """
    Write an issue to markdown file
    """
    with open(join(ISSUES_DIR, '%s.md' % key), "w") as fptr:
        fptr.write(Template(tpl).render({
            "lcs": key,
            "title": title,
            "milestone": milestone,
            "labels": item["labels"],
            "page": item["page"],
            "body": item["body"],
            "mwe": item["mwe"]
        }))


def write_issue(tpl, title, milestone, item):
    """
    Create/update an issue in a GitHub repository
    """
    mdbody = Template(TPL).render({
        "page": item["page"],
        "body": item["body"],
        "mwe": item["mwe"]
    })
    try:
        print("UPDATE", title)
        issue = EXISTING[title]
        labels = [label.name for label in issue.labels] + item["labels"] if len(issue.labels) != 0 else item["labels"]
        issue.edit(
            body=mdbody,
            labels=labels,
            milestone=MILESTONE,
        )
    except KeyError:
        print("CREATE", title)
        GHR.create_issue(
            title=title,
            body=mdbody,
            labels=item["labels"],
            milestone=MILESTONE,
        )


DATA = get_data()
DISABLED = {}

MILESTONE = configure(ARGS.repo)

if ARGS.tool:
    process_tool(ARGS.tool)

print_summary(DATA, DISABLED)

for key, val in DATA.items():
    isISAC = key[0:4] == "ISAC"

    page = check_key(val, "page", "LCS"+(key[5:] if isISAC else key[4:]).replace('-', '_'))

    item = {
        "labels": ARGS.isac_labels if isISAC else ARGS.lcs_labels,
        "page": "http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/%s" % page,
        "body": check_key(val, "body", "*empty body*"),
        "mwe": check_key(val, "mwe", "*not available yet*")
    }

    if ARGS.repo:
        write_issue(
            TPL,
            issue_title(key, val["title"]),
            MILESTONE,
            item
        )
    else:
        write_md(
            TPL_META + TPL,
            key,
            val["title"],
            ARGS.milestone,
            item
        )
