#
# Credit:
# https://github.com/myusuf3/dotfiles/blob/master/myusuf3.zsh-theme
#

PROMPT='%{$fg[magenta]%}[%c] $(git_prompt_info) $(hg_prompt_info) %{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} %{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$reset_color%} %{$fg[yellow]%}["
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN=""
