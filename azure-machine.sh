# install xfce4
sudo apt-get update
sudo apt-get -y install xfce4
sudo apt install xfce4-session

# install xrpd
sudo apt-get install xrdp
sudo systemctl enable xrdp

# set desktop environment manager on rdp
echo xfce4-session > ~/.xsession

# restart xrpd for chances to have effect
sudo service xrdp restart

# install git
sudo apt-get install git

# install azure utility
sudo apt install azure-cli

# install anaconda prerequisites
sudo apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# download and install anaconda
filename=$(curl https://repo.anaconda.com/archive/ | grep  Linux-x86_64 | sed -n '$p' | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d')
url=https://repo.anaconda.com/archive/$filename
wget $url
sudo chmod +x $filename
bash $filename -b  -p $HOME/anaconda3
rm $filename

# activate shell
source $HOME/anaconda3/etc/profile.d/conda.sh
./anaconda3/bin/conda init