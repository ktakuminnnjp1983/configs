# .bashrc
ROOT_GITHUBDIR=/home/kobayashi/gitdirs/github
ROOTDIR=/home/kobayashi

. ~/.commonrc

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=50000
export HISTFILESIZE=$HISTSIZE 


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
