# Usage: eww-workspaces
#
# Follows niri's event stream and prints, on every change, one JSON line with the
# workspaces of each output:
#   {"<output>": [{"idx": 1, "active": true, "occupied": true}, ...], ...}
# The bar reads it with deflisten and shows the entry of its own output.

snapshot() {
  local workspaces windows

  workspaces=$(niri msg --json workspaces) || return 1
  windows=$(niri msg --json windows) || return 1

  jq -cn --argjson workspaces "$workspaces" --argjson windows "$windows" '
    [$windows[].workspace_id] as $occupied
    | $workspaces
    | map(select(.output != null))
    | group_by(.output)
    | map({
        key: .[0].output,
        value: (sort_by(.idx) | map({
          idx,
          active: .is_active,
          occupied: (.id as $id | any($occupied[]; . == $id))
        }))
      })
    | from_entries'
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

# the event stream ends when niri restarts; reconnect instead of leaving the bar stale
while true; do
  emit
  while read -r event; do
    case $event in
      '{"Workspace'* | '{"Window'*) emit ;;
    esac
  done < <(niri msg --json event-stream 2>/dev/null || true)
  sleep 1
done
