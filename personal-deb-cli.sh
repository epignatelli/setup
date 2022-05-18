function update_repos () {
    sudo apt-get update
    sudo apt update
}

function install_git () {
    # install git
    sudo apt-get -y install git
}

function install_anaconda () {
    # exit if anaconda already installed
    if [ ! -d ~/anaconda3 ]; then
        # install anaconda prerequisites
        sudo apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
        
        # get latest linux version
        filename=$(curl https://repo.anaconda.com/archive/ | grep  Linux-x86_64 | sed -n '$p' | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d')
        url=https://repo.anaconda.com/archive/$filename

        # download and install anaconda
        wget $url
        sudo chmod +x $filename
        bash $filename -b -p $HOME/anaconda3
        rm $filename        
    fi

    # activate shell
    source $HOME/anaconda3/etc/profile.d/conda.sh
    
    # activate on login
    echo "source $HOME/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
}

function install_miniforge () {
    # get latest Miniforge
    release='Linux-x86_64'
    url=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$release.sh
    filename=Miniforge3-latest-$release.sh
    
    # download and install miniforge
    wget $url
    sudo chmod +x $filename
    bash $filename
    rm $filename
}

function enable_ohmyzsh_plugin () {
    # TODO(ep): check for the plugin keyword to already exist
    sed 's/^plugins=(\(.*\)/plugins=($1 \1/' $HOME/.zshrc
}

function install_ohmyzsh () {
    # install zsh
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -
    
    # enable zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins
    enable_ohmyzsh_plugin 'zsh-syntax-highlighting'
    
    # enable zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins
    enable_ohmyzsh_plugin 'zsh-autosuggestions'
}

function install_thefuck () {
    pip install thefuck
}

# main
update_repos
install_git
install_anaconda
install_ohmyzsh
enable_ohmyzsh_plugin
install_thefuck
