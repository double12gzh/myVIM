export ZSH="/root/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(
 git extract last-working-dir zsh-autosuggestions
 wd #zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

umask 0022
export DISPLAY=localhost:0.0

eval $(dircolors -b $HOME/.dircolors)
eval "$(direnv hook zsh)"

export HISTCONTROL=erasedups:ignorespace
export HISTSIZE=5000

export PATH=/root/anaconda3/bin:$PATH
umask 0022

export DISPLAY=localhost:0.0
export JAVA_HOME=/opt/jdk1.8.0_231
export PATH=$JAVA_HOME/bin:$PATH:/root/istio-1.10.1/bin
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
unsetopt BG_NICE

alias vimz='vim $(fzf)'
alias f='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias cdhd='cd /home/AFiles/dockerVolumes'
alias cdh='cd /home/AFiles'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ccat='highlight --line-numbers -O ansi --force'
alias k='kubectl'

#PROMPT="%B%F{2}[%f%b%B%F{green}%n%f%b%B%F{green}@%f%b%B%F{green}%m%f%b%B%F{green} %f%b%B%F{green}%~%f%b%B%F{green}]%f%b"
export GOPATH=/home/.go
export GOROOT=/usr/local/go
export GO111MODULE=on
#export GOPROXY=https://goproxy.cn,direct
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin:/home/.go/bin
export DIR=/usr/local
export LD_LIBRARY_PATH=:/usr/local/lib
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
