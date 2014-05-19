#!/bin/sh

sudo yum install firefox
sudo yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
sudo yum install mercurial
sudo yum install ncurses ncurses-devel
sudo yum install python-devel ruby-devel
sudo yum install lua lua-devel
sudo yum lvm2
sudo yum install pcre pcre-devel
sudo yum install xz-devel

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
if [ ! -e ${ROOT_GITHUBDIR}/vim ]; then
    git clone git@github.com:ktakuminnnjp1983/vim ${ROOT_GITHUBDIR}/vim
fi

if [ ! -e ~/.vim ]; then
    echo mk .vim
    mkdir ~/.vim
    mkdir ~/.vim/undo
    ln -s ${ROOT_GITHUBDIR}/vim/after ~/.vim
fi

rm ~/.bashrc ~/.zshrc ~/.vimrc
ln -s ${ROOT_GITHUBDIR}/configs/.bashrc ~/.bashrc 
ln -s ${ROOT_GITHUBDIR}/configs/.zshrc ~/.zshrc 
ln -s ${ROOT_GITHUBDIR}/vim/.vimrc ~/.vimrc 

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

