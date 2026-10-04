# Usage: eww-popup toggle <window>
#
# Opens the eww popup window on the focused output, or closes it if it is open.

[[ ${1:-} == toggle && -n ${2:-} ]] || {
  echo "usage: eww-popup toggle <window>" >&2
  exit 2
}
window=$2

if eww active-windows | grep -q "^$window:"; then
  eww close "$window"
else
  # GTK has no primary monitor under niri, so name the focused output explicitly
  output=$(niri msg --json focused-output | jq -r '.name // empty') || output=
  eww open "$window" ${output:+--screen "$output"}
fi
