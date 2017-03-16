source $bp_dir/bin/common.sh


export_env_dir $env_dir


check_compliance() {
  status "Production branch detected, running long tests..."
  # Script to run codecheck
  cd $build_dir
  rm -rf .codecheck
  git clone --depth 1 https://${GITHUB_USERNAME}:${API_TOKEN}@github.com/EliLillyCo/CIRR_HerokuCI.git .codecheck
  status "Start Cirrus codecheck process: `date`"
  java -jar .codecheck/jar/herokuci.jar
  status "End Cirrus codecheck process: `date`"
}
