# Usage: eww-brightness
#
# Prints the backlight brightness in percent, one line per change. The bar
# reads it with deflisten. Hosts without a backlight (desktop) print nothing.

host_file=${XDG_CONFIG_HOME:-$HOME/.config}/eww/host.json

jq -e '.laptop' "$host_file" >/dev/null || exit 0

# device,class,current,percent,max
IFS=, read -r device _ <<<"$(brightnessctl --machine-readable info)"
brightness_file=/sys/class/backlight/$device/brightness

last=
emit() {
  local value

  IFS=, read -r _ _ _ value _ <<<"$(brightnessctl --machine-readable info)"
  value=${value%\%}
  if [[ $value != "$last" ]]; then
    printf '%s\n' "$value"
    last=$value
  fi
}

while true; do
  emit
  # writes through sysfs (brightnessctl) wake us at once; the timeout (exit
  # status 2) catches changes the firmware makes without one. Any other failure
  # must not turn this into a busy loop.
  inotifywait -qq -t 10 -e modify "$brightness_file" || (($? == 2)) || sleep 10
done
