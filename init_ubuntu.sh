#!/bin/sh-E apt install -y gnome-session-flashback
sudo -E apt install -y git
sudo -E apt install -y curl
#sudo apt install -y perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
sudo -E apt install -y mercurial
#sudo apt install -y ncurses ncurses-devel
#sudo apt install -y python-devel ruby-devel
sudo -E apt install -y lua5.3 liblua5.3-dev
#sudo apt install -y vm2
#sudo apt install -y pcre pcre-devel
#sudo apt install -y xz-devel
sudo -E apt install -y python-docutils
sudo -E apt install -y ssh
sudo -E apt install -y ctags
sudo -E apt install -y silversearcher-ag
sudo -E apt install -y octave
sudo -E apt install -y scilab
sudo -E apt build-dep -y vim
sudo -E apt build-dep -y zsh
sudo -E apt build-dep -y scilab
sudo -E apt build-dep -y octave
sudo -E apt install -y zsh
sudo -E apt install -y python-testresources
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo -E python3 get-pip.py
sudo -E pip install jupyterlab

ROOTDIR=/home/kobayashi
ROOT_GITDIR=${ROOTDIR}/gitdirs
ROOT_GITHUBDIR=${ROOT_GITDIR}/github
ROOT_GITGITDIR=${ROOT_GITDIR}/git

if [ ! -e ${ROOT_GITDIR} ]; then
    mkdir ${ROOT_GITDIR}
fi
if [ ! -e ${ROOT_GITHUBDIR} ]; then
    mkdir ${ROOT_GITHUBDIR}
fi
if [ ! -e ${ROOT_GITGITDIR} ]; then
    mkdir ${ROOT_GITGITDIR}
fi

if [ ! -e ${ROOT_GITHUBDIR}/configs ]; then
    git clone git@github.com:ktakuminnnjp1983/configs ${ROOT_GITHUBDIR}/configs
fi
if [ ! -e ${ROOT_GITHUBDIR}/vim ]; then
    git clone git@github.com:ktakuminnnjp1983/vim ${ROOT_GITHUBDIR}/vim
fi
if [ ! -e ${ROOT_GITHUBDIR}/scripts ]; then
    git clone git@github.com:ktakuminnnjp1983/scripts ${ROOT_GITHUBDIR}/scripts
fi
if [ ! -e ${ROOT_GITDIR}/nvm ]; then
    git clone git://github.com/creationix/nvm.git ${ROOT_GITDIR}/nvm
fi
if [ ! -e ${ROOT_GITGITDIR}/vim ]; then
    git clone git@github.com:vim/vim.git ${ROOT_GITGITDIR}/vim
fi

if [ ! -e ~/.vim ]; then
    echo mk .vim
    mkdir ~/.vim
    mkdir ~/.vim/undo
    mkdir ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    ln -s ${ROOT_GITHUBDIR}/vim/after ~/.vim
fi

rm -f ~/.bashrc ~/.zshrc ~/.vimrc
ln -s ${ROOT_GITHUBDIR}/configs/.bashrc ~/.bashrc 
ln -s ${ROOT_GITHUBDIR}/configs/.zshrc ~/.zshrc 
ln -s ${ROOT_GITHUBDIR}/vim/.vimrc ~/.vimrc 
ln -s ${ROOT_GITHUBDIR}/configs/.gitconfig ~/.gitconfig
ln -s ${ROOT_GITHUBDIR}/configs/.gitignore ~/.gitignore
ln -s ${ROOT_GITHUBDIR}/scripts/myscript ~/myscript

if [ ! -e ~/.commonrc ]; then
    ln -s ${ROOT_GITHUBDIR}/configs/.commonrc ~/.commonrc
fi





