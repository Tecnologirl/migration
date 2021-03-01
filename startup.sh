#PREWORK
sudo yum -y update
sudo yum -y -qq install git
git clone https://github.com/tecnologirl/migration
cd migration
chmod +x script.sh
./script.sh
