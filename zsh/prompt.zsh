autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

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
      echo " $(git_tag)%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo " $(git_tag)%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_tag(){
  echo "%{$fg_bold[blue]%}@"
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
 # echo "(%{\e[33m%}${ref#refs/heads/}%{\e[0m%})" #=> @(master)
 echo "${ref#refs/heads/}" #=> @master
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  echo "$(rbenv version | awk '{print $1}')"
}

rb_prompt() {
  echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%}"
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\%{$reset_color%}"
}

# emojis in the prompt.
export PROMPT=$'$(directory_name) $(rb_prompt)$(git_dirty)$(need_push)%(?:🐥 :👹 %s) '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  set_prompt
}
