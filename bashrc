stty -ixon

# PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\0274 \[\033[0m\]\[\e[01;33m\]\\$ \[\e[0m\]"

PS1=" \w\[\033[0;34m >>>\[\e[0m\] "

# LS_COLORS='di=34;1:fi=0:ln=33:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=32:*.rpm=90'
# export LS_COLORS

#------------------------------
# Completion
#------------------------------
complete -cf sudo
complete -cf man

export GOPATH=$HOME/Development/go
export PATH=$GOPATH/bin:$PATH

source $HOME/.dotfiles/shell-aliases
