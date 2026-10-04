# Usage: eww-network
#
# Follows NetworkManager and prints, on every change, one JSON line:
#   {"state": "wired" | "wifi" | "disconnected", "icon": "..."}
# For Wi-Fi the icon shows the signal strength in steps. The bar reads it with
# deflisten.

# NetworkManager reports no event when only the signal strength changes
refresh_after=15

snapshot() {
  local devices signal

  devices=$(nmcli --terse --fields TYPE,STATE device) || return 1
  # prefix match, so "connected (externally)" counts too
  if grep -q '^ethernet:connected' <<<"$devices"; then
    jq -cn --arg icon $'\U000f0200' '{state: "wired", icon: $icon}'
  elif grep -q '^wifi:connected' <<<"$devices"; then
    signal=$(nmcli --terse --fields IN-USE,SIGNAL device wifi list --rescan no |
      awk -F: '$1 == "*" { print $2; exit }')
    jq -cn --arg icon "$(wifi_icon "${signal:-0}")" '{state: "wifi", icon: $icon}'
  else
    jq -cn --arg icon $'\U000f0c9b' '{state: "disconnected", icon: $icon}'
  fi
}

wifi_icon() {
  local signal=$1

  if ((signal >= 80)); then
    printf '%s' $'\U000f0928'
  elif ((signal >= 60)); then
    printf '%s' $'\U000f0925'
  elif ((signal >= 40)); then
    printf '%s' $'\U000f0922'
  elif ((signal >= 20)); then
    printf '%s' $'\U000f091f'
  else
    printf '%s' $'\U000f092f'
  fi
}

last=
emit() {
  local current

  current=$(snapshot) || return 0
  if [[ $current != "$last" ]]; then
    printf '%s\n' "$current"
    last=$current
  fi
}

# the monitor ends when NetworkManager restarts; reconnect instead of leaving the bar stale
while true; do
  emit
  while true; do
    if read -r -t "$refresh_after" _; then
      emit
    elif (($? > 128)); then
      # timed out: pick up a new signal strength
      emit
    else
      break
    fi
  done < <(nmcli monitor 2>/dev/null || true)
  sleep 1
done
