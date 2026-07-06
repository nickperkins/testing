#!/usr/bin/env bash
# Installs the testing skill into every supported AI agent skills directory
# it finds on this machine. Use --project to install into the current repo
# instead of your home directory.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/nickperkins/testing-skill/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/nickperkins/testing-skill/main/install.sh | bash -s -- --project
#
# Or run locally from the repo root:
#   ./install.sh            # personal (home dir)
#   ./install.sh --project   # current repo only

set -euo pipefail

# --- resolve repo root (directory containing this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# --- defaults
SCOPE="personal"
TARGETS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)  SCOPE="project"; shift ;;
    --personal) SCOPE="personal"; shift ;;
    -h|--help)
      sed -n '2,14p' "${BASH_SOURCE[0]:-$0}"
      exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

# --- determine install roots by scope
# Personal = $HOME-based dirs; Project = repo-relative dirs.
# The skill folder is named `testing` so it becomes the `/testing` command.
if [[ "$SCOPE" == "personal" ]]; then
  [[ -d "$HOME/.claude"   ]] && TARGETS+=("$HOME/.claude/skills/testing")
  [[ -d "$HOME/.copilot"  ]] && TARGETS+=("$HOME/.copilot/skills/testing")
  [[ -d "$HOME/.agents"   ]] && TARGETS+=("$HOME/.agents/skills/testing")
  [[ -d "$HOME/.pi/agent" ]] && TARGETS+=("$HOME/.pi/agent/skills/testing")
else
  ROOT="$(pwd)"
  [[ -d "$ROOT/.claude"  ]] && TARGETS+=("$ROOT/.claude/skills/testing")
  [[ -d "$ROOT/.github"  ]] && TARGETS+=("$ROOT/.github/skills/testing")
  [[ -d "$ROOT/.agents"  ]] && TARGETS+=("$ROOT/.agents/skills/testing")
  [[ -d "$ROOT/.pi"      ]] && TARGETS+=("$ROOT/.pi/skills/testing")
fi

if [[ ${#TARGETS[@]} -eq 0 ]]; then
  echo "No supported agent skills directories found."
  echo "Create one first, e.g.:  mkdir -p ~/.claude/skills"
  exit 1
fi

# --- copy the skill folder into each target
SRC="$SCRIPT_DIR"
if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "SKILL.md not found next to this script ($SRC). Run from the repo root." >&2
  exit 1
fi

installed=0
for dest in "${TARGETS[@]}"; do
  parent="$(dirname "$dest")"
  mkdir -p "$parent"
  rm -rf "$dest"
  cp -R "$SRC" "$dest"
  # keep only skill contents, not this installer
  rm -f "$dest/install.sh"
  echo "installed → $dest"
  installed=$((installed + 1))
done

echo
echo "Done. Installed to $installed location(s)."
echo "Invoke with: /testing"
