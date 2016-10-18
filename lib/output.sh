info() {
  echo "$*" || true
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

warn() {
  local message=${1:-}
  local suggestion=${2:-https://devcenter.heroku.com/articles/nodejs-support}
  echo "" || true
  echo -e "\033[93m\033[1m\033[40m=!= $message\033[0m" || true
  echo "$suggestion"
}

error() {
  echo "" || true
  echo -e "\033[91m\033[1m\033[40m=!= $*\033[0m" || true
}
