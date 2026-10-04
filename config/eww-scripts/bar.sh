# Usage: eww-bar
#
# Opens one bar per monitor listed in host.json. Run by the eww service after
# the daemon starts.

host_file=${XDG_CONFIG_HOME:-$HOME/.config}/eww/host.json

# `eww open` would start a second daemon if this one is not listening yet
until eww ping >/dev/null 2>&1; do
  sleep 0.1
done

while read -r monitor; do
  # a disconnected monitor must not keep the others without a bar
  eww open bar --id "bar-$monitor" --screen "$monitor" --arg "monitor=$monitor" ||
    echo "eww-bar: could not open the bar on $monitor" >&2
done < <(jq -r '.monitors[]' "$host_file")
