#!/bin/bash

which librarian-chef > /dev/null && exit 0
set -e
ruby_version=$1
[ -z $ruby_version ] && ruby_version=2.1.2
if [ ! -d ~/.rbenv ]; then
  sudo apt-get update
  sudo apt-get install -y git autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev
  echo install: --no-rdoc --no-ri > ~/.gemrc
  echo update: --no-rdoc --no-ri >> ~/.gemrc
  if ! ssh-keygen -q -H -F github.com >/dev/null 2>&1; then
    echo "adding github.com to known_hosts"
    ssh-keyscan -H github.com 2>/dev/null >> ~/.ssh/known_hosts
  fi
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
  cat <<EOF >~/.rbenvrc
if ! echo \$PATH | grep -q rbenv; then
  export PATH=~/.rbenv/bin:\$PATH
  eval "\$(rbenv init -)"
fi
EOF
  echo source \~/.rbenvrc >> ~/.profile
fi
. ~/.rbenvrc
rbenv install -s $ruby_version
rbenv global $ruby_version
gem which bundler >/dev/null 2>&1 || gem install bundler
rbenv rehash
export BUNDLE_GEMFILE=Gemfile.chef
bundle
rbenv rehash
bundle exec librarian-chef install
