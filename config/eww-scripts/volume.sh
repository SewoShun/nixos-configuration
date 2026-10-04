# Usage: eww-volume
#
# Follows PipeWire (through its PulseAudio interface) and prints, on every
# change of the default sink, one JSON line:
#   {"value": 40, "muted": false, "icon": "..."}
# The bar reads it with deflisten, so changes made outside the volume keys
# (pavucontrol and so on) are shown too.
#
# volume_state comes from volume-state.sh, prepended by lib/eww-volume.nix.

last=
emit() {
  local current

  volume_state || return 0
  current=$(jq -cn --argjson value "$volume_value" --argjson muted "$volume_muted" --arg icon "$volume_icon" \
    '{value: $value, muted: $muted, icon: $icon}')
  if [[ $current != "$last" ]]; then
    printf '%s\n' "$current"
    last=$current
  fi
}

# the subscription ends when PipeWire restarts; reconnect instead of leaving the bar stale
while true; do
  emit
  while read -r event; do
    case $event in
      # volume or mute of a sink, or a new default sink
      *" on sink "* | *" on server "*) emit ;;
    esac
  done < <(pactl subscribe 2>/dev/null || true)
  sleep 1
done
