# Install the isolated Omarchy session only when it is not already present.
# This does not enable, replace, or re-theme the login manager.

mkdir -p "$HOME/.config/uwsm"
uwsm_env="$HOME/.config/uwsm/env"
if [[ ! -e "$uwsm_env" ]]; then
  install -m644 "$OMARCHY_PATH/default/uwsm-env-Hyprland" "$uwsm_env"
elif ! grep -q '^[[:space:]]*export HYPRLAND_CONFIG=' "$uwsm_env"; then
  printf '\n# Omarchy integration: select the regular config, not an auto-discovered Lua config.\n' >>"$uwsm_env"
  printf 'export HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"\n' >>"$uwsm_env"
fi

session_launcher=/usr/local/bin/omarchy-hyprland-session
session_entry=/usr/local/share/wayland-sessions/omarchy-profile.desktop

if [[ ! -e "$session_launcher" ]]; then
  sudo install -Dm755 "$OMARCHY_PATH/default/omarchy-hyprland-session" "$session_launcher"
fi

if [[ ! -e "$session_entry" ]]; then
  sudo install -Dm644 "$OMARCHY_PATH/default/omarchy-profile.desktop" "$session_entry"
fi
