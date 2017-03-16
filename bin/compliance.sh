source $bp_dir/bin/common.sh


export_env_dir $env_dir


check_compliance() {
  echo "Production branch detected, running long tests..."
  # Script to run codecheck
  rm -rf .codecheck
  git clone --depth 1 https://${GITHUB_USERNAME}:${API_TOKEN}@github.com/EliLillyCo/CIRR_HerokuCI.git .codecheck
  .codecheck/runtests | indent
}
