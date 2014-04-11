echo "Enter the Server:"
read server
echo "Enter your User:"
read userlogin

ssh $userlogin@$server << EOF

echo "Enter the user:"
read username
echo "Enter the name for the repository:"
read reponame
echo "Your input was $username and $reponame. Is this correct? (y/n)"
read userinput

while true; do
  echo "Your input was $username and $reponame. Is this correct? (y/n)"
  read userinput
  case userinput in
    [Yy]*) break;;
    [Nn]*) exit;;
    *) "Please answer yes or no.";;
  esac
done

if [! -d "$DIRECTORY"]; then
  adduser $username

mkdir /home/$username/$reponame".git"
cd /home/$username/$reponame".git"
git --bare init

EOF
