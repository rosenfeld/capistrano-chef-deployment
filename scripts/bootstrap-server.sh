#!/bin/sh

set -e
deploy_user=$1

echo Bootstraping server... installing sudo
if ! which sudo > /dev/null; then
  apt-get update
  apt-get install -y sudo
fi
echo Setting nopasswd in sudo settings for $deploy_user user
cat <<EOF >/etc/sudoers.d/$deploy_user-nopasswd
$deploy_user ALL=(ALL:ALL) NOPASSWD: ALL
EOF
if [ ! -d /home/$deploy_user ]; then
  echo creating user $deploy_user
  adduser --disabled-password --gecos "" $deploy_user
else
  echo user $deploy_user already existed
fi
if [ ! -d /home/$deploy_user/.ssh/id_rsa.pub ]; then
  echo setting up $deploy_user ssh deploy keys
  mkdir -p /home/$deploy_user/.ssh
  mv /tmp/deploy-key /home/$deploy_user/.ssh/id_rsa
  mv /tmp/deploy-key.pub /home/$deploy_user/.ssh/id_rsa.pub
  cp /home/$deploy_user/.ssh/id_rsa.pub /home/$deploy_user/.ssh/authorized_keys
  chmod 0600 /home/$deploy_user/.ssh/id_rsa
  chown -R $deploy_user:$deploy_user /home/$deploy_user/.ssh
fi
echo Server is bootstraped successfully
