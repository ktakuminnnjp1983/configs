# .zshrc sample
# http://d.hatena.ne.jp/oovu70/20120405/p1
# zsh 最新 http://zsh.sourceforge.net/Arc/source.html

# (d) is default on

# ------------------------------
# General Settings
# ------------------------------
. /home/kobayashi/.commonrc

fpath=(~/gitdirs/zsh-completions/src $fpath)
#----- auto-fu
if [ -f ~/gitdirs/auto-fu.zsh/auto-fu.zsh ]; then
    source ~/gitdirs/auto-fu.zsh/auto-fu.zsh
    function zle-line-init ()
    {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi

# autoload predict-on
# predict-on

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

bindkey -e               # キーバインドをemacsモードに設定
#bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt pushd_ignore_dups # pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -Uz compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
# bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu selection

### vimのキーバインドで候補の選択 ###
zmodload -i zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### cdr ###
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 100
zstyle ":chpwd:*" recent-dirs-default on
zstyle ":completion:*" recent-dirs-insert always
zstyle ":completion:*:*:cdr:*:*" menu selection
zstyle ":chpwd:*" recent-dirs-file "$HOME/.zsh_recent"

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=50000            # メモリに保存されるヒストリの件数
SAVEHIST=50000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_all_dups # 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
# export LSCOLORS=Exfxcxdxbxegedabagacad
# # 補完時の色の設定
# export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# # ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# # 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
p1="%n[%40<...<%~]%# "
p2="%_> "
p3="%r is correct? [Yes, No, Abort, Edit]:"
# 一般ユーザ時
tmp_prompt="%{${fg[green]}%}$p1%{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}$p2${reset_color}"
# tmp_rprompt="%{${fg[green]}%}[%40<...<%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}$p3%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%{${fg[red]}%}%B%U${p1}%u%b%{${reset_color}%}"
    tmp_prompt2="%{${fg[red]}%}%B%U${p2}%u%b%{${reset_color}%}"
    # tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%{${fg[red]}%}%B%U${p3}%u%b%{${reset_color}%}"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
# RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

