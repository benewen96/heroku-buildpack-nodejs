info() {
  echo "       $*" || true
}

# format output and send a copy to the log
output() {
  local logfile="$1"

  while read LINE;
  do
    echo "$LINE" || true
    echo "$LINE" >> "$logfile" || true
  done
}

header() {
  echo "" || true
  echo -e "\033[95m\033[1m=== $*\033[0m" || true
}

error() {
  echo "" || true
  echo "!!! $*" >&2 || true
}
