# Install the isolated Omarchy session only when it is not already present.
# This does not enable, replace, or re-theme the login manager.

session_launcher=/usr/local/bin/omarchy-hyprland-session
session_entry=/usr/local/share/wayland-sessions/omarchy-profile.desktop

if [[ ! -e "$session_launcher" ]]; then
  sudo install -Dm755 "$OMARCHY_PATH/default/omarchy-hyprland-session" "$session_launcher"
fi

if [[ ! -e "$session_entry" ]]; then
  sudo install -Dm644 "$OMARCHY_PATH/default/omarchy-profile.desktop" "$session_entry"
fi
