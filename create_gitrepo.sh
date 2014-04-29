#!/bin/bash

echo "Enter the Server:"
read SERVER
echo "Enter your root-username:"
read USERLOGIN
echo "Enter the username of the repository owner:"
read USERNAME
echo "Enter the name for the repository:"
read REPONAME

while true; do
  echo "Create new git repo $REPONAME for user $USERNAME. Continue? (y/n)"
  read USERINPUT
  case $USERINPUT in
    [Yy]*) break;;
    [Nn]*) exit;;
    *) "Please answer yes or no.";;
  esac
done

ssh $USERLOGIN@$SERVER bash -c "

  if [!-d "/home/$USERNAME"]; then
    "first create the user with git-setup.sh!"
    exit
  fi

  mkdir /home/$USERNAME/$REPONAME".git"
  cd /home/$USERNAME/$REPONAME".git"
  git --bare init
  cd ..
  chown $USERNAME -R $REPONAME".git"
  chgrp $USERNAME -R $REPONAME".git"

"
