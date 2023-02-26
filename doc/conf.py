# -*- coding: utf-8 -*-

from pathlib import Path
from json import loads as json_loads
from yaml import load as yaml_load, Loader as yaml_Loader
from tabulate import tabulate

ROOT = Path(__file__).resolve().parent


# -- Generate 2019.inc and 2019/*.rst ----------------------------------------------------------------------------------

with open(ROOT.parent / "issues/LCS2019.yml", "r", encoding="utf-8") as stream:
    LCS2019 = yaml_load(stream, Loader=yaml_Loader)

(ROOT / '2019').mkdir(exist_ok=True)

with open(ROOT / "2019.inc", "w", encoding="utf-8") as index_fptr:
    index_fptr.write('''\
.. toctree::
  :caption: 2019
  :hidden:

''')

    for key, val in LCS2019.items():
        index_fptr.write(f'  2019/{key}\n')
        with open(ROOT / f"2019/{key}.rst", "w", encoding="utf-8") as item_fptr:
            item_fptr.write(f'''\
{key}
{'#'*len(key)}

{val['title']}

{val['body']}
''')

# -- General configuration ---------------------------------------------------------------------------------------------

extensions = [
    "sphinx.ext.extlinks",
    "sphinx.ext.intersphinx",
]

source_suffix = {
    ".rst": "restructuredtext",
}

master_doc = "index"
project = "VHDL Compliance Tests"
author = "Open Source VHDL Group contributors"
copyright = f"2019-2023, {author}"

version = "latest"
release = version  # The full version, including alpha/beta/rc tags.

language = 'en'

exclude_patterns = [
    "_build",
]

numfig = True

# -- Options for HTML output -------------------------------------------------------------------------------------------

html_context = {}
ctx = ROOT / "context.json"
if ctx.is_file():
    html_context.update(json_loads(ctx.open("r").read()))

html_theme = "furo"

# -- Sphinx.Ext.InterSphinx --------------------------------------------------------------------------------------------

intersphinx_mapping = {
    "python": ("https://docs.python.org/3/", None),
}

# -- Sphinx.Ext.ExtLinks -----------------------------------------------------------------------------------------------

extlinks = {
    "wikipedia": ("https://en.wikipedia.org/wiki/%s", None),
    "gl": ("https://gitlab.com/%s", "gl:%s"),
    "gh": ("https://github.com/%s", "gh:%s"),
    "ghsharp": ("https://github.com/VHDL/Compliance-Tests/issues/%s", "#%s"),
    "ghissue": ("https://github.com/VHDL/Compliance-Tests/issues/%s", "issue #%s"),
    "ghpull": ("https://github.com/VHDL/Compliance-Tests/pull/%s", "pull request #%s"),
    "ghsrc": ("https://github.com/VHDL/Compliance-Tests/blob/main/%s", "%s"),
}
