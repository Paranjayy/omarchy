# Omarchy (Non-Vanilla Fork)

A patched fork of [basecamp/omarchy](https://github.com/basecamp/omarchy) that allows installing Omarchy on **non-vanilla Arch Linux systems** — systems with existing desktop environments, systemd-boot, ext4, or other non-standard configurations.

## What's Patched

| File | Change |
|------|--------|
| `install/preflight/guard.sh` | `OMARCHY_UNGUARDED=1` skips all preflight aborts (GNOME/KDE, Limine, Btrfs, Secure Boot) |
| `install/login/hibernation.sh` | Skips btrfs swapfile setup on non-btrfs roots |
| `install/login/sddm.sh` | `systemctl enable --force sddm.service` handles GDM conflicts |
| `install/login/reenable-mkinitcpio.sh` | New — re-enables disabled alpm hooks + rebuilds initramfs on non-Limine |
| `install/login/limine-snapper.sh` | Guards unconditional `/boot/limine.conf` checks behind Limine check |
| `install/config/config.sh` | Skips `.bashrc` overwrite when `OMARCHY_UNGUARDED=1` |

## What Happens on Your System

- **Existing DEs** (GNOME, KDE, Niri, etc.) — packages are **not removed**. They stay installed. SDDM becomes the login manager.
- **systemd-boot** — untouched. Omarchy does not install Limine or modify your bootloader.
- **ext4** — works. Btrfs-specific features (snapper snapshots, btrfs swapfile hibernation) are skipped.
- **Configs** — merged into `~/.config/`. Existing GNOME/Plasma/Niri configs are untouched. Hyprland/Waybar configs are replaced with Omarchy defaults.
- **`.bashrc`** — preserved (not overwritten) when using `OMARCHY_UNGUARDED=1`.
- **pacman.conf** — overwritten with Omarchy's config (adds Omarchy mirror + keyring). Safe.
- **Packages** — only added, never removed.

## Install

Boot your existing Arch system and run:

```bash
curl -fsSL https://omarchy.org/install | OMARCHY_REPO=Paranjayy/omarchy OMARCHY_REF=master bash
```

### Environment Variables

| Variable | Description |
|----------|-------------|
| `OMARCHY_REPO` | GitHub repo to clone (default: `basecamp/omarchy`) |
| `OMARCHY_REF` | Branch to use (default: `master`) |
| `OMARCHY_UNGUARDED=1` | Skip all preflight guards — **required** for non-vanilla systems |

## Tested On

- Arch Linux with systemd-boot, ext4 root
- Multiple DEs: GNOME, KDE Plasma, Niri, Hyprland
- Intel i3-9100F, RX 550, 24GB RAM

## Upstream

This fork only patches install scripts. All runtime code (`bin/`, `config/`, etc.) is identical to upstream. Future upstream updates can be pulled with:

```bash
cd ~/.local/share/omarchy
git remote add upstream https://github.com/basecamp/omarchy.git
git fetch upstream
git merge upstream/master
```

## Credits

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — the original Omarchy project
