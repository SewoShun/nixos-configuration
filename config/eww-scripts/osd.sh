# Usage: eww-osd volume {up|down|mute}
#        eww-osd brightness {up|down}
#
# Changes the value, pushes it to the eww OSD and (re)starts the hide timer.

step=5
hide_after=1.5

runtime_dir=${XDG_RUNTIME_DIR:-/tmp}
token_file=$runtime_dir/eww-osd-token
host_file=${XDG_CONFIG_HOME:-$HOME/.config}/eww/host.json

show() {
  local icon=$1 value=$2 muted=$3 token active

  eww update "osd_icon=$icon" "osd_value=$value" "osd_muted=$muted"

  active=$(eww active-windows)
  if ! grep -q '^osd:' <<<"$active"; then
    # a concurrent key press may have opened it already; that must not skip the timer reset below
    eww open osd || true
  fi

  # only the timer started by the latest key press may close the OSD
  token=$(date +%s%N)
  printf '%s' "$token" >"$token_file"
  (
    sleep "$hide_after"
    if [[ $(<"$token_file") == "$token" ]]; then
      eww close osd
    fi
  ) >/dev/null 2>&1 &
  disown
}

volume() {
  local sink=@DEFAULT_AUDIO_SINK@ out value muted=false icon

  case ${1:-} in
    up) wpctl set-volume --limit 1.0 "$sink" "${step}%+" ;;
    down) wpctl set-volume "$sink" "${step}%-" ;;
    mute) wpctl set-mute "$sink" toggle ;;
    *) usage ;;
  esac

  out=$(wpctl get-volume "$sink")
  value=$(awk '{ printf "%d", $2 * 100 + 0.5 }' <<<"$out")
  if [[ $out == *MUTED* ]]; then
    muted=true
    icon=$'\U000f075f'
  elif ((value == 0)); then
    icon=$''
  elif ((value < 50)); then
    icon=$''
  else
    icon=$''
  fi

  show "$icon" "$value" "$muted"
}

brightness() {
  local line value

  # hosts without a backlight (desktop) do nothing
  jq -e '.laptop' "$host_file" >/dev/null || exit 0

  case ${1:-} in
    up) line=$(brightnessctl --machine-readable --min-value set "${step}%+") ;;
    down) line=$(brightnessctl --machine-readable --min-value set "${step}%-") ;;
    *) usage ;;
  esac

  # device,class,current,percent,max
  IFS=, read -r _ _ _ value _ <<<"$line"

  show $'\U000f00e0' "${value%\%}" false
}

usage() {
  echo "usage: eww-osd volume {up|down|mute} | brightness {up|down}" >&2
  exit 2
}

case ${1:-} in
  volume) volume "${2:-}" ;;
  brightness) brightness "${2:-}" ;;
  *) usage ;;
esac
