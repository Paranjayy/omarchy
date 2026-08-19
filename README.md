# Omarchy (Non-Vanilla Fork)

A patched fork of [basecamp/omarchy](https://github.com/basecamp/omarchy) that allows installing Omarchy on **any Arch Linux system** — systems with existing desktop environments, any bootloader, any filesystem, or other non-standard configurations.

## What's Patched

| File | Change |
|------|--------|
| `install/preflight/guard.sh` | DE/FS checks optional; `--allow-any-de`, `--allow-any-fs`, `--unguarded` flags |
| `install/login/hibernation.sh` | Skips btrfs swapfile setup on non-btrfs roots |
| `install/login/sddm.sh` | `systemctl enable --force sddm.service` handles GDM conflicts |
| `install/login/reenable-mkinitcpio.sh` | Re-enables disabled alpm hooks + rebuilds initramfs on non-Limine |
| `install/login/limine-snapper.sh` | Guards unconditional `/boot/limine.conf` checks behind Limine check |
| `install/config/config.sh` | Skips `.bashrc` overwrite when `OMARCHY_UNGUARDED=1` |

## What's New

- **Any DE** — GNOME, KDE, Niri, i3, sway, etc. can coexist. Omarchy doesn't remove them.
- **Any filesystem** — ext4, xfs, btrfs, etc. all work. Btrfs-specific features auto-skip.
- **Any bootloader** — systemd-boot, GRUB, Limine, etc. Omarchy doesn't touch your boot setup.
- **Dotfiles backup** — backup/restore/sync all WM/DE configs with one command.

## What Happens on Your System

- **Existing DEs** — packages are **not removed**. They stay installed. SDDM becomes the login manager.
- **Bootloader** — untouched. Omarchy does not install or modify your bootloader.
- **Filesystem** — works on any FS. Btrfs-specific features (snapper, swapfile hibernation) auto-skip.
- **Configs** — merged into `~/.config/`. Existing configs are untouched. Hyprland/Waybar configs are set to Omarchy defaults.
- **`.bashrc`** — preserved (not overwritten) when using `--unguarded`.
- **pacman.conf** — overwritten with Omarchy's config (adds Omarchy mirror + keyring). Safe.
- **Packages** — only added, never removed.

## Quick Install (Clone & Go)

```bash
# Clone the repo
git clone https://github.com/Paranjayy/omarchy.git ~/.local/share/omarchy
cd ~/.local/share/omarchy

# Install (safe integration mode — preserves everything)
omarchy install

# Or with all checks skipped
omarchy install --unguarded
```

## Install Options

```bash
omarchy install                          # Safe integration mode (default)
omarchy install --allow-any-de           # Skip "existing DE" check
omarchy install --allow-any-fs           # Skip "btrfs required" check
omarchy install --unguarded              # Skip ALL safety checks
```

### One-liner from upstream installer

```bash
curl -fsSL https://omarchy.org/install | OMARCHY_REPO=Paranjayy/omarchy OMARCHY_REF=agent/fix-uwsm-config-selection bash
```

## Updating

```bash
omarchy update              # Pull latest from your fork branch
omarchy update -y           # Skip confirmation
omarchy update available    # Check if updates exist
```

## Dotfiles Backup

Backup all your WM/DE/terminal configs:

```bash
omarchy dotfiles-backup                          # Backup to ~/Backups/dotfiles/
omarchy dotfiles-backup --output ~/my-backups    # Custom location
omarchy dotfiles-restore ~/Backups/dotfiles/20260819-054753  # Restore
omarchy dotfiles-sync --repo ~/dotfiles          # Backup + git push
```

### What gets backed up

- Hyprland (hyprland.conf, hypridle, hyprlock, etc.)
- Plasma/KDE (plasmashellrc, kdeglobals, etc.)
- Niri (config.kdl)
- Omarchy (branding, themes, extensions)
- GTK (gtk-3.0, gtk-4.0)
- Terminals (alacritty, foot, kitty, ghostty)
- Waybar, Walker, Mako, UWSM, SwayOSD
- Shell configs (.bashrc, .zshrc, .tmux.conf, .gitconfig)

## Environment Variables

| Variable | Description |
|----------|-------------|
| `OMARCHY_REPO` | GitHub repo to clone (default: `basecamp/omarchy`) |
| `OMARCHY_REF` | Branch to use (default: `master`) |
| `OMARCHY_UNGUARDED=1` | Skip all preflight guards |
| `OMARCHY_REQUIRE_FRESH=1` | Enforce fresh-install-only (no existing DEs) |
| `OMARCHY_REQUIRE_BTRFS=1` | Enforce btrfs-only root filesystem |

## Tested On

- Arch Linux with systemd-boot, ext4 root
- Multiple DEs: GNOME, KDE Plasma, Niri, Hyprland
- Intel i3-9100F, RX 550, 24GB RAM

## Upstream

This fork patches install scripts and adds dotfiles tools. Runtime code (`bin/`, `config/`, etc.) tracks upstream. Pull updates with:

```bash
cd ~/.local/share/omarchy
git remote add upstream https://github.com/basecamp/omarchy.git
git fetch upstream
git merge upstream/master
```

Or simply:

```bash
omarchy update
```

## Credits

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — the original Omarchy project
