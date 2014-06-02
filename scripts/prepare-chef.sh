#!/bin/sh

set -e
git_path=$1
git_host=$2
provisioning_path=~/provisioning
deployment_path=$provisioning_path/deployment

echo Preparing Chef deployment...
echo git_path: $git_path
echo git_host: $git_host
[ -f /home/deploy/.rbenv/shims/librarian-chef ] && echo server was already prepared && exit 0
if ! which git > /dev/null; then
  echo installing git...
  sudo apt-get update
  sudo apt-get install -y git
fi

mkdir -p $provisioning_path
if [ ! -d $deployment_path ]; then
  if [ ! -z $git_host ] && ! ssh-keygen -q -H -F $git_host >/dev/null; then
    echo "adding git host to known_hosts"
    ssh-keyscan -H $git_host 2>/dev/null >> ~/.ssh/known_hosts
  fi
  if [ -z $symlink ]; then
    echo cloning deployment project
    git clone $git_path $deployment_path
  else
    echo symlinking $deployment_path to $git_path
    ln -s $git_path $deployment_path
  fi
fi
cd $deployment_path
echo installing chef
./install-chef.sh
echo Server is ready to run Chef recipes
