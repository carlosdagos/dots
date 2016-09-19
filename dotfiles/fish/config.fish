set -g fisher_home ~/.local/share/fisherman
set -g fisher_config ~/.config/fisherman
source $fisher_home/config.fish

alias emacs 'emacs -nw'
alias bubu  'brew update; brew outdated; brew upgrade; brew cleanup'

set PATH $PATH /usr/local/sbin

if test -d $HOME/Library/Haskell/bin
    set PATH $PATH $HOME/Library/Haskell/bin
end

if test -d $HOME/.local/bin
    set PATH $PATH $HOME/.local/bin
end

if test -d $HOME/.bin
    set PATH $PATH $HOME/.bin
end
