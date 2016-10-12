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
  echo -e "\033[96m\033[1m\033[40m=== $*\033[0m" || true
}

error() {
  echo "" || true
  echo -e "\033[93m\033[1m\033[40m! $*\033[0m" >&2 || true
}
