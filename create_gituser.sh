#!/bin/bash

echo "Enter the Server:"
read SERVER
echo "Enter your User:"
read USERLOGIN
echo "New Usergroup:"
read USERGROUP

while true; do
  echo "Create new git user: $USERGROUP. Continue? (y/n)"
  read USERINPUT
  case $USERINPUT in
    [Yy]*) break;;
    [Nn]*) exit;;
    *) "Please answer yes or no.";;
  esac
done

ssh $USERLOGIN@$SERVER bash -c "

  adduser $USERGROUP
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

usermod -s /usr/bin/git-shell $USERGROUP

"
