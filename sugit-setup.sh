#!/bin/bash

echo "Enter the Server:"
read SERVER
echo "Enter your User:"
read USERLOGIN
echo "New Usergroup:"
read USERGROUP

ssh $USERLOGIN@$SERVER bash -c "

  sudo adduser $USERGROUP
  su $USERGROUP
  cd
  mkdir ~/.ssh
  touch ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys

"

echo "Path to ssh key (s for standard, create with ssh-keygen):"
read USERINPUT

case $USERINPUT in
  [Ss]*) ssh-copy-id -i ~/.ssh/id_rsa.pub $USERGROUP@$SERVER;;
  *) ssh-copy-id -i $USERINPUT $USERGROUP@$SERVER;;
esac

ssh $USERLOGIN@$SERVER bash -c "

  sudo usermod -s /usr/bin/git-shell $USERGROUP

"
