function install_rdp {
    # install xfce4
    sudo apt-get update
    sudo apt-get -y install xfce4
    sudo apt-get -y install xfce4-session

    # install xrpd
    sudo apt-get -y install xrdp
    sudo systemctl enable xrdp

    # set desktop environment manager on rdp
    echo xfce4-session > ~/.xsession

    # restart xrpd for chances to have effect
    sudo service xrdp restart
}

function install_git {
    # install git
    sudo apt-get -y install git
}

function install_azure_cli {
    # install azure utility
    sudo apt-get -y install azure-cli
}

function install_anaconda {
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
    
    # activate on login
    echo "source $HOME/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
}

function install_chrome {
    # download chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt-get -y install ./google-chrome-stable_current_amd64.deb
}

install_rdp
install_git
install_azure_cli
install_chrome
conda list || install_anaconda
