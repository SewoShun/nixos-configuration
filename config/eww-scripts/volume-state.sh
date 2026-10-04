# Shared by eww-osd and eww-volume (prepended to both scripts by lib/eww-*.nix).
#
# volume_state reads the default sink and sets volume_value (0-100),
# volume_muted (true/false) and volume_icon.

volume_state() {
  local out

  out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@) || return 1
  volume_value=$(awk '{ printf "%d", $2 * 100 + 0.5 }' <<<"$out")
  volume_muted=false
  if [[ $out == *MUTED* ]]; then
    volume_muted=true
    volume_icon=$'\U000f075f'
  elif ((volume_value == 0)); then
    volume_icon=$''
  elif ((volume_value < 50)); then
    volume_icon=$''
  else
    volume_icon=$''
  fi
}
