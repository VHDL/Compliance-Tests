This subdir contains the list of approved Language Change Specifications (LCS) for VHDL-2019 in a machine readable format ([YAML](https://yaml.org/)). This is intented for developers/maintainers of tools that aim to support VHDL-2019, so that they can easily generate issues in their trackers.

# Description

The content was copied from [TWiki> P1076 Web>VHDL2017](http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/VHDL2017). Each item in `LCS2019.yml` is an object containing four fields:

- [required] title
- [optional] page: if the URL to the corresponding page at P1076 Wiki cannot be generated automatically, provide a custom path here.
- [optional] body: main content, including a summary or description.
- [optional] mwe: markdown code-blocks with the file decorators explained in [issue-runner](https://github.com/eine/issue-runner/tree/master#supported-markdown-syntax).

As a complement for projects hosted at GitHub, a Python script (`issues.py`) can be used to generate a GitHub issue for each LCS:

```
usage: issues.py [-h] [-r REPO] [-l [LCS_LABELS [LCS_LABELS ...]]] [-i [ISAC_LABELS [ISAC_LABELS ...]]] [-m MILESTONE] [-t TOOL]

optional arguments:
  -h, --help            show this help message and exit

  -r REPO, --repo REPO  remote repository to create the issues at

  -l [LCS_LABELS [LCS_LABELS ...]], --lcs-labels [LCS_LABELS [LCS_LABELS ...]]
                        labels for regular LCS issues

  -i [ISAC_LABELS [ISAC_LABELS ...]], --isac-labels [ISAC_LABELS [ISAC_LABELS ...]]
                        labels for ISAC issues

  -m MILESTONE, --milestone MILESTONE
                        milestone to assign all issues

  -t TOOL, --tool TOOL  YAML file to customize the list and MWEs
```

 The most relevant features of this script are the following:

- Two sets of **labels** are assigned: one is used for regular LCS items and another one is used for Issue Screening and Analysis (ISAC) items.
- If any of the issues exists, the body (main message of the issue) is updated, but the state, other labels and reactions are preserved.
- If `--repo` is not provided, a *dry run* is executed, which will generate a markdown file for each item, instead of creating/updating an issue in some repo. Markdown files include YAML metada (title, labels, milestone, etc.).
- The list of items can be filtered and/or the Minimal Working Examples (MWEs) can be customized for specific repos/tools by providing an auxiliary YAML file through `--tool`.
  - This YAML file should contain the subset of items to be processed, and the content of each item is read as additional sources to be appended to the corresponding MWE. See, for example, [ghdl.yml](./tools/ghdl.yml).
  - The summary shows which items are disabled or extended through the provided tool configuration script.

# Usage

The expected usage of these resources for developers of projects hosted at GitHub is to add a GitHub Actions workflow such as the following:

```yaml
name: 'VHDL 2019'

on:
  push:
  schedule:
    - cron: '0 0 * * *'

jobs:
  issues:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/setup-python@v1
      with:
        python-version: 3.7
    - run: python -m pip install -r https://raw.githubusercontent.com/VHDL/Compliance-Tests/master/issues/requirements.txt
    - run: |
        curl -fsSL https://raw.githubusercontent.com/VHDL/Compliance-Tests/master/issues/issues.py |\
        python - -l 'FeaReq: LCS-2019' -i 'FeaReq: ISAC-2019' -m 'VHDL-2019' -r '${{github.repository}}'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

- The workflow is executed periodically. Hence, whenever `LCS2019.yml` is updated upstream (in this repo), the bodies of the issues in the target repo will be updated automatically.
- The default [`GITHUB_TOKEN`](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/authenticating-with-the-github_token) is used. As a result, the author of the issues is a bot, and no Personal Access Token (PAT) or Deployment Key need to be generated/maintained.

# Development

Script `issues.py` prints a summary of the available info for each LCS. A table with four columns is shown:

- Title: is the title defined?
  - 'x' if defined, else ''.
- Page: is a custom page defined?
  - 'x' if custom, else 'a' (auto).
- Body: is the body defined?
  - 'x' if defined, else ''.
- MWE: is the MWE defined? is it extended through the tool configuration file?
  - 't' if extended, else 'x' if defined, else ''.

Currently, titles are available for all of them, but only a custom page, few summaries and a couple of MWEs have been copied. Unfortunately, the remaining work needs to be done manually. Any contribution to complete `LCS2019.yml` is welcome!

Tool configuration files are expected to be located in other repos, but we can host them here if some vendors are not proactive.

The Python script is functional but limited to GitHub. We'd be glad to accept any contribution to enhance it by supporting other target hosts (say GitLab, Bitbucket, Gitea, etc.).

# References

- [gitlab.com/synthworks/VHDL_2019](https://gitlab.com/synthworks/VHDL_2019) contains sources/examples used in the *VHDL-2019: Just the New Stuff* series of webminars organised by [Aldec](https://www.aldec.com/en/search).
