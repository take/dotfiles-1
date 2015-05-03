#!/usr/bin/env bash

tempfile=/tmp/my-serverkit.zip
workspace=/tmp/my-serverkit

# Download zipped installer
curl -LSfs -o ${tempfile} https://github.com/take/my-serverkit/archive/master.zip

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Move to repository root path
pushd ${workspace}/my-serverkit-master > /dev/null

# Install command-line-tools
if [[ ! -d /usr/include ]]; then
  PLACEHOLDER=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  touch $PLACEHOLDER
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
  softwareupdate -i "${PROD}"
  [[ -f $PLACEHOLDER ]] && rm $PLACEHOLDER
fi

# Install homebrew
which brew > /dev/null
if [ "$?" -ne 0 ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install serverkit and its dependencies
export GEM_HOME=`pwd`/vendor/bundle
gem install bundler
./vendor/bundle/bin/bundle install --path vendor/bundle > /dev/null

# Run installer
bundle exec serverkit apply recipe.yml.erb --variables=variables.yml
unset GEM_HOME

# Move to original path
popd > /dev/null

# Cleanup
rm -rf ${tempfile} ${workspace}
