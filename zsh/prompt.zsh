autoload colors && colors

git="$commands[git]"

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo " $(git_branch_prefix)%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo " $(git_branch_prefix)%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_branch_prefix(){
  echo "%{$fg_bold[blue]%}->"
}

git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  # echo "(%{\e[33m%}${ref#refs/heads/}%{\e[0m%})" #=> @(master)
  echo " ${ref#refs/heads/}" #=> @master
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [ $($git rev-parse --is-inside-work-tree 2>/dev/null) ]
  then
    number=$($git cherry -v origin/$(git symbolic-ref --short HEAD) 2>/dev/null | wc -l | bc)

    if [[ $number == 0 ]]
    then
      echo ""
    else
      echo " with %{$fg_bold[magenta]%}$number unpushed%{$reset_color%}"
    fi
  fi
}

#################
# Ruby version
#################
ruby_version() {
  echo "$(rbenv version | awk '{print $1}')"
}

rb_prompt() {
  echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%}"
}

#################
# Directory
#################
directory_name() {
  echo "%{$fg_bold[cyan]%}%~%{$reset_color%}"
}

# emojis in the prompt.
export PROMPT=$'$(directory_name) $(rb_prompt)$(git_dirty)$(need_push) %(?:🐥 :👹 %s) '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  set_prompt
}
