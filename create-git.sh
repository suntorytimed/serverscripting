#!/bin/bash

echo "Enter the Server:"
read SERVER
echo "Enter your User:"
read USERLOGIN
echo "Enter the user:"
read USERNAME
echo "Enter the name for the repository:"
read REPONAME

while true; do
  echo "Your input was $USERNAME and $REPONAME. Is this correct? (y/n)"
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
