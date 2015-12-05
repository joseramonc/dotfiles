# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'


alias md='mkdir -p'
alias d='dirs -v | head -10'
