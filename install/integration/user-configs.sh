# Install only missing user configuration files. Existing configs are never
# overwritten, so KDE, GNOME, Niri, OpenCode, and other user settings survive.
mkdir -p "$HOME/.config"
for entry in "$OMARCHY_PATH/config"/*; do
  target="$HOME/.config/$(basename "$entry")"
  if [[ ! -e "$target" && ! -L "$target" ]]; then
    cp -R "$entry" "$target"
  fi
done

if [[ ${OMARCHY_UNGUARDED:-0} != "1" && ! -e "$HOME/.bashrc" ]]; then
  cp "$OMARCHY_PATH/default/bashrc" "$HOME/.bashrc"
fi
