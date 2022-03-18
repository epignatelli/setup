function install_git () {
    # install git
    sudo yum -y install git
}

function install_anaconda () {
    # exit if anaconda already installed
    if [ ! -d ~/anaconda3 ]; then
        # install anaconda prerequisites
        yum -y install libXcomposite libXcursor libXi libXtst libXrandr alsa-lib mesa-libEGL libXdamage mesa-libGL libXScrnSaver
        
        # get latest linux version
        filename=$(curl https://repo.anaconda.com/archive/ | grep  Linux-x86_64 | sed -n '$p' | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d')
        url=https://repo.anaconda.com/archive/$filename
        
        # download and install anaconda
        wget $url
        sudo chmod +x $filename
        bash $filename -b  -p $HOME/anaconda3
        rm $filename        
    fi

    # activate shell
    source $HOME/anaconda3/etc/profile.d/conda.sh
    
    # activate on login
    echo "source $HOME/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
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

install_git
install_anaconda
install_ohmyzsh
