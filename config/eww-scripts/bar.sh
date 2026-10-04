# Usage: eww-bar
#
# Opens one bar per monitor listed in host.json, telling each bar whether the
# host is a laptop (brightness and battery are shown only there) and whether
# its monitor is the primary one (the system tray is shown only there). Run by
# the eww service after the daemon starts.

host_file=${XDG_CONFIG_HOME:-$HOME/.config}/eww/host.json

# `eww open` would start a second daemon if this one is not listening yet
until eww ping >/dev/null 2>&1; do
  sleep 0.1
done

laptop=$(jq '.laptop' "$host_file")
primary_monitor=$(jq -r '.primaryMonitor' "$host_file")

while read -r monitor; do
  primary=false
  if [[ $monitor == "$primary_monitor" ]]; then
    primary=true
  fi
  # a disconnected monitor must not keep the others without a bar
  eww open bar --id "bar-$monitor" --screen "$monitor" \
    --arg "monitor=$monitor" --arg "laptop=$laptop" --arg "primary=$primary" ||
    echo "eww-bar: could not open the bar on $monitor" >&2
done < <(jq -r '.monitors[]' "$host_file")
