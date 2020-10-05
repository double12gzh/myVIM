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

export PATH=/root/anaconda3/bin:$PATH
umask 0022

export DISPLAY=localhost:0.0
export JAVA_HOME=/opt/jdk1.8.0_231
export PATH=$JAVA_HOME/bin:$PATH

[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
unsetopt BG_NICE

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ccat='highlight -O ansi --force'