#!/bin/sh

sudo  apt install -y perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
sudo  apt install -y mercurial
sudo  apt install -y ncurses ncurses-devel
sudo  apt install -y python-devel ruby-devel
sudo  apt install -y lua lua-devel
sudo  apt install -y vm2
sudo  apt install -y pcre pcre-devel
sudo  apt install -y xz-devel
sudo  apt install -y python-docutils
sudo  apt install -y ssh
sudo  apt build-dep vim
sudo  apt build-dep zsh

ROOTDIR=/home/kobayashi
ROOT_GITDIR=${ROOTDIR}/gitdirs
ROOT_GITHUBDIR=${ROOT_GITDIR}/github

if [ ! -e ${ROOT_GITDIR} ]; then
    mkdir ${ROOT_GITDIR}
fi
if [ ! -e ${ROOT_GITHUBDIR} ]; then
    mkdir ${ROOT_GITHUBDIR}
fi

if [ $UID -eq 0 -a ! -e ~/gitdirs ]; then
    ln -s ${ROOT_GITDIR} ~/gitdirs
fi

if [ ! -e ${ROOT_GITHUBDIR}/configs ]; then
    git clone git@github.com:ktakuminnnjp1983/configs ${ROOT_GITHUBDIR}/configs
fi
if [ ! -e ${ROOT_GITHUBDIR}/vim ]; thenconfigs
    git clone git@github.com:ktakuminnnjp1983/vim ${ROOT_GITHUBDIR}/vim
fi
if [ ! -e ${ROOT_GITHUBDIR}/scripts ]; then
    git clone git@github.com:ktakuminnnjp1983/scripts ${ROOT_GITHUBDIR}/scripts
fi

if [ ! -e ~/.vim ]; then
    echo mk .vim
    mkdir ~/.vim
    mkdir ~/.vim/undo
    ln -s ${ROOT_GITHUBDIR}/vim/after ~/.vim
fi

rm -f ~/.bashrc ~/.zshrc ~/.vimrc
ln -s ${ROOT_GITHUBDIR}/configs/.bashrc ~/.bashrc 
ln -s ${ROOT_GITHUBDIR}/configs/.zshrc ~/.zshrc 
ln -s ${ROOT_GITHUBDIR}/vim/.vimrc ~/.vimrc 
ln -s ${ROOT_GITHUBDIR}/configs/.gitconfig ~/.gitconfig
ln -s ${ROOT_GITHUBDIR}/configs/.gitignore ~/.gitignore
ln -s ${ROOT_GITHUBDIR}/scripts/myscript ~/myscript
 

if [ $UID -eq 0 -a ! -e ~/.vim ]; then
    ln -s ${ROOTDIR}/.vim ~/.vim 
fi
if [ $UID -eq 0 -a ! -e ~/.bash_history ]; then
    ln -s ${ROOTDIR}/.bash_history ~/.bash_history 
fi
if [ $UID -eq 0 -a ! -e ~/.zsh_history ]; then
    ln -s ${ROOTDIR}/.zsh_history ~/.zsh_history 
fi

if [ ! -e ~/.commonrc ]; then
    ln -s ${ROOT_GITHUBDIR}/configs/.commonrc ~/.commonrc
fi

