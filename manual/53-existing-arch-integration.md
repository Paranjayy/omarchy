# Existing Arch integration

Omarchy can be installed as a desktop profile on an existing Arch Linux
system. This mode is intentionally separate from the Omarchy ISO installer.

```bash
omarchy integrate --yes
```

The integration path installs only the small Hyprland/UWSM package set and
adds an `Omarchy (portable profile)` session. It does not select or enable a
display manager, replace an SDDM greeter, change another desktop environment,
or assume Btrfs. Ext4 and other filesystems are supported as long as Arch is
already booting normally.

It also does not run the ISO system, hardware, login, or post-install
orchestration. In particular, it does not rewrite NetworkManager or
`pacman.conf`, change mirrors, configure Snapper/Limine, modify bootloader or
initramfs state, or enable SDDM. Existing files are preserved; files created
by the integration command are backed up before any replacement and the
portable session can be selected from the user's existing greeter.

KDE Plasma, GNOME, Niri, and other installed desktops remain available. The
portable session only launches Hyprland and does not make Omarchy the default
desktop.
