#!/usr/bin/env bash
set -e
set -x

SRC=${1:-"src/zenml tests"}
SRC_NO_TESTS=${1:-"src/zenml"}

export ZENML_DEBUG=1
export ZENML_ANALYTICS_OPT_IN=false
flake8 $SRC
autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place $SRC --exclude=__init__.py --check
isort $SRC scripts --check-only
black $SRC  --check
interrogate $SRC_NO_TESTS -c pyproject.toml
mypy $SRC_NO_TESTS
codespell CODE-OF-CONDUCT.md
codespell CONTRIBUTING.md
codespell ROADMAP.md
codespell README.md
codespell RELEASE_NOTES.md
codespell src/
codespell docs/book
codespell examples/
