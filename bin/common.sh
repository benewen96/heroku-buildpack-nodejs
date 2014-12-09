error() {
  echo " !     $*" >&2
  exit 1
}

status() {
  echo "-----> $*"
}

protip() {
  tip=$1
  url=$2
  echo
  echo "PRO TIP: $tip" | indent
  echo "See ${url:-https://devcenter.heroku.com/articles/nodejs-support}" | indent
}

file_contents() {
  if test -f $1; then
    echo "$(cat $1)"
  else
    echo ""
  fi
}

package_json() {
  local result="$(cat $build_dir/package.json | $bp_dir/vendor/jq -r $1)"
  if [ "$result" == "null" ]; then echo ""
  else echo "$result"
  fi
}

# sed -l basically makes sed replace and buffer through stdin to stdout
# so you get updates while the command runs and dont wait for the end
# e.g. npm install | indent
indent() {
  c='s/^/       /'
  case $(uname) in
    Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
    *)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
  esac
}

cat_npm_debug_log() {
  test -f $build_dir/npm-debug.log && cat $build_dir/npm-debug.log
}

tail_error_log() {
  echo ""
  echo " !     Build failure:"
  echo ""
  tail -n 500 $logfile | indent
}

export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-''}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}
  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export "$e=$(cat $env_dir/$e)"
      :
    done
  fi
}

quote() {
  local url="http://www.iheartquotes.com/api/v1/random?source=prog_style+esr+osp_rules+esr&max_lines=3&show_permalink=false&show_source=false"
  local text=$(curl --max-time 3 $url 2> /dev/null)
  local withQuotes=${text//&quot;/\"}
  local withAmps=${withQuotes//&amp;/&}
  echo ""
  echo $withAmps
  echo ""
}
