#!/usr/bin/env bash
# bootstrap/link.sh
# Creates symlinks from the live filesystem into this dotfiles repo.
# Safe to re-run: skips symlinks that already point to the right target.
#
# Usage:
#   ./bootstrap/link.sh             # desktop / full machine
#   ./bootstrap/link.sh --server    # shell-only profile (no nvim, no tmux-desktop bindings)
#   ./bootstrap/link.sh --container # minimal: git + shell only
#
# This script does NOT install packages, manage themes, or touch Omarchy config.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="${1:-}"

link() {
  local src="$1"   # file inside dotfiles/
  local dst="$2"   # live filesystem path

  # Expand ~ manually since we may be sourced with varying environments
  dst="${dst/#\~/$HOME}"

  local dir
  dir="$(dirname "$dst")"

  if [ ! -d "$dir" ]; then
    echo "  mkdir $dir"
    mkdir -p "$dir"
  fi

  if [ -L "$dst" ]; then
    local current
    current="$(readlink "$dst")"
    if [ "$current" = "$src" ]; then
      echo "  ok    $dst"
      return
    else
      echo "  relink $dst  ($current -> $src)"
      rm "$dst"
    fi
  elif [ -e "$dst" ]; then
    echo "  SKIP  $dst  (exists, not a symlink — move it manually)"
    return
  fi

  ln -s "$src" "$dst"
  echo "  link  $dst -> $src"
}

echo "==> dotfiles: $DOTFILES"
echo "==> profile:  ${PROFILE:-desktop}"
echo ""

# ── Always: git ────────────────────────────────────────────────────────────────
echo "[git]"
link "$DOTFILES/git/config"  "~/.config/git/config"
link "$DOTFILES/git/ignore"  "~/.config/git/ignore"
echo ""

# ── Always: shell ──────────────────────────────────────────────────────────────
echo "[zsh]"
link "$DOTFILES/zsh/.zshrc"          "~/.zshrc"
link "$DOTFILES/starship/starship.toml"  "~/.config/starship.toml"
echo ""

# ── Desktop / server: tmux ─────────────────────────────────────────────────────
if [ "$PROFILE" != "--container" ]; then
  echo "[tmux]"
  link "$DOTFILES/tmux/local.conf"  "~/.config/tmux/local.conf"
  echo ""
fi

# ── Desktop only: neovim ───────────────────────────────────────────────────────
if [ "$PROFILE" = "" ]; then
  echo "[nvim]"
  link "$DOTFILES/nvim/options.lua"               "~/.config/nvim/lua/config/options.lua"
  link "$DOTFILES/nvim/plugins/smear-cursor.lua"  "~/.config/nvim/lua/plugins/smear-cursor.lua"
  echo ""
fi

echo "==> done"
