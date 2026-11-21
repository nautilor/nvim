#!/usr/bin/env bash
# Update lazy-lock.json in THIS folder by running lazy.nvim headless.
#
# nvim is pointed at this checkout via a temporary XDG_CONFIG_HOME, and uses a
# separate plugin directory (~/.cache/nvim-lock-update) so your live plugins in
# ~/.local/share/nvim are never touched. First run clones everything (slow);
# later runs reuse the cache.
#
# Usage:
#   ./update-lock.sh                  # sync all plugins (install/update/clean)
#   ./update-lock.sh matugen.nvim     # sync only the given plugin(s)
#   ./update-lock.sh --restore        # reset plugins to the commits in the lockfile

set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lock="$repo/lazy-lock.json"
sandbox="${XDG_CACHE_HOME:-$HOME/.cache}/nvim-lock-update"

command -v nvim >/dev/null || { echo "nvim not found" >&2; exit 1; }
[ -f "$repo/init.lua" ] || { echo "init.lua not found in $repo" >&2; exit 1; }

mkdir -p "$sandbox/config" "$sandbox/data" "$sandbox/state" "$sandbox/cache"
ln -sfn "$repo" "$sandbox/config/nvim"

echo "lockfile: $lock"

if [ "${1:-}" = "--restore" ]; then
	cmd="Lazy! restore"
else
	cmd="Lazy! sync $*"
fi

XDG_CONFIG_HOME="$sandbox/config" \
XDG_DATA_HOME="$sandbox/data" \
XDG_STATE_HOME="$sandbox/state" \
XDG_CACHE_HOME="$sandbox/cache" \
	nvim --headless "+$cmd" +qa 2>&1 | sed 's/\x1b\[[0-9;]*m//g' | tail -n 20 || true

# lazy.nvim writes the lockfile without a trailing newline; add one.
[ -n "$(tail -c1 "$lock")" ] && echo >>"$lock"

echo
git -C "$repo" --no-pager diff --stat -- lazy-lock.json || true
