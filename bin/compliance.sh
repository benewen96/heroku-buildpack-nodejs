source $bp_dir/bin/common.sh


check_compliance() {
  echo "Compliance checks echo!"
  echo $HEROKU_TEST_RUN_BRANCH
  # if we're on the master branch, then run production tests (i.e. codecheck)
  if [ "$HEROKU_TEST_RUN_BRANCH" == "master" ]
  then
      echo "Production branch detected, running long tests..."
      # Script to run codecheck
      rm -rf .codecheck
      git clone --depth 1 https://${GITHUB_USERNAME}:${API_TOKEN}@github.com/EliLillyCo/CIRR_HerokuCI.git .codecheck
      .codecheck/runtests | indent
  fi
}
