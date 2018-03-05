# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi
alias g=$hub_path
alias g=git

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gcm='git commit -S'
alias gco='git checkout'
alias gb='git branch'
alias gst='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias ga='git add'
alias guncache='git rm --cached -r '
compdef g=git
