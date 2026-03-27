# dotfiles

Personal config, extracted from an Omarchy-based desktop. Additive only — does not
replace Omarchy defaults, just layers on top of them via override hooks.

## What lives here

| File | Live path | Notes |
|---|---|---|
| `git/config` | `~/.config/git/config` | Identity, aliases, diff/push prefs |
| `git/ignore` | `~/.config/git/ignore` | Global gitignore |
| `zsh/.zshrc` | `~/.zshrc` | Personal aliases, colors, and shell additions |
| `starship/starship.toml` | `~/.config/starship.toml` | Starship prompt — cyan minimal theme |
| `tmux/local.conf` | `~/.config/tmux/local.conf` | Personal tmux bindings, sourced by Omarchy's tmux.conf |
| `nvim/options.lua` | `~/.config/nvim/lua/config/options.lua` | Personal vim options (guicursor etc.) |
| `nvim/plugins/smear-cursor.lua` | `~/.config/nvim/lua/plugins/smear-cursor.lua` | Cursor trail plugin |

## What is NOT here (Omarchy-managed)

Do not copy these into this repo — they may be overwritten by `omarchy update`:

- `~/.config/tmux/tmux.conf` — Omarchy base tmux config (has a `source local.conf` hook at the end)
- `~/.config/nvim/lua/plugins/` — Omarchy plugin files (theme, all-themes, etc.)
- `~/.config/nvim/lua/config/lazy.lua`, `keymaps.lua`, `autocmds.lua` — Omarchy stubs
- `~/.config/omarchy/` — theme configuration
- `~/.local/share/omarchy/` — Omarchy source

## Applying symlinks

```bash
git clone <repo-url> ~/dotfiles
~/dotfiles/bootstrap/link.sh
```

The script is safe to re-run. It skips symlinks that already point to the right place,
and warns (without overwriting) if a non-symlink file exists at the target path.

## Profiles

```bash
./bootstrap/link.sh              # desktop — all links
./bootstrap/link.sh --server     # git + shell + tmux, no nvim
./bootstrap/link.sh --container  # git + shell only
```

## Porting to another machine

### Another desktop / laptop (Omarchy)
1. Install Omarchy per its instructions
2. `git clone <repo> ~/dotfiles`
3. `./dotfiles/bootstrap/link.sh`

### Server (shell-only)
1. `git clone <repo> ~/dotfiles`
2. `./dotfiles/bootstrap/link.sh --server`

   The server doesn't need Omarchy. The tmux local.conf will be linked, but it only
   applies if you also have a tmux.conf that sources it. On a plain server you can
   either use a minimal tmux.conf that sources `~/.config/tmux/local.conf`, or skip
   tmux entirely.

### Container shell (user-level tooling)
1. In your Dockerfile/containerfile, clone the repo during user setup
2. Run `./dotfiles/bootstrap/link.sh --container`
3. This gives you git identity and zsh config without any desktop or editor setup

## Adding new personal config

1. Put the file in the appropriate subdirectory here
2. Run `link.sh` to create/update the symlink, OR manually: `ln -s ~/dotfiles/... ~/.config/...`
3. Add it to the table above and to `bootstrap/link.sh`
4. Commit

## tmux note

Omarchy's `~/.config/tmux/tmux.conf` sources `local.conf` at the end via:

```tmux
if-shell "[ -f ~/.config/tmux/local.conf ]" "source ~/.config/tmux/local.conf"
```

If Omarchy ever overwrites `tmux.conf`, check that this line is still present. The
file is at `~/.local/share/omarchy/config/tmux/tmux.conf` upstream.
