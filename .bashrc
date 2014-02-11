# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ ! -e $HOME/gitdirs/github/configs -o ! -e $HOME/gitdirs/github/vim ]; then
    echo "gitdirs not exist"
    exit 1
fi

if [ ! -e ~/.commonrc ]; then
    ln -s ~/gitdirs/github/configs/.commonrc ~/.commonrc
fi

. ~/.commonrc

if [ -e $HOME/.commonfxrc ]; then
    . $HOME/.commonfxrc
fi

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=50000
export HISTFILESIZE=$HISTSIZE 

