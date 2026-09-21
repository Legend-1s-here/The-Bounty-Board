#!/usr/bin/env bash
# Generates a lightweight repo map to seed .agents/memory/architecture-map.md.
#
# Prefers `git ls-files` (respects .gitignore, fast, no node_modules noise);
# falls back to `find` with common excludes if this isn't a git repo.
#
# This intentionally does NOT try to auto-write the map file or guess at
# module ownership — the annotations you add by hand afterward (what a
# module owns, what it must not depend on) are the part actually worth
# spending tokens to read later. This script only saves you the typing.
#
# Usage:
#   ./scripts/generate-repo-map.sh            # depth 3, all tracked files
#   ./scripts/generate-repo-map.sh 2          # shallower
#   ./scripts/generate-repo-map.sh 5 src/     # deeper, scoped to a folder

set -euo pipefail

MAX_DEPTH="${1:-3}"
SCOPE="${2:-.}"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "# Repo map — git-tracked files under '${SCOPE}', depth ${MAX_DEPTH}"
  echo "# (regenerate with scripts/generate-repo-map.sh; paste the relevant"
  echo "#  part into .agents/memory/architecture-map.md and annotate by hand)"
  echo
  git ls-files -- "${SCOPE}" \
    | awk -F/ -v depth="$MAX_DEPTH" '{ if (NF <= depth) print }' \
    | sort
else
  echo "# Repo map — not a git repo, showing files under '${SCOPE}', depth ${MAX_DEPTH}"
  echo
  find "${SCOPE}" -maxdepth "$MAX_DEPTH" \
    \( -name node_modules -o -name .git -o -name dist -o -name build \
       -o -name .venv -o -name venv -o -name __pycache__ \
       -o -name .next -o -name target \) -prune -o \
    -type f -print \
    | sed 's|^\./||' \
    | sort
fi
