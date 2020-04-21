# In osx, prioritize the nix load path
switch (uname)
    case Darwin
        set -gx PATH /run/current-system/sw/bin $PATH
end

# My aliases
alias nvim  'nvim -u ~/.nvimrc'
alias ls    'exa'
alias l     'ls -la'
alias la    'ls -la'

set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

# Use the `falcon` colors for exa
set -gx EXA_COLORS 'uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:fi=38;5;248:di=38;5;253:ex=38;5;1:xa=38;5;12:*.png=38;5;4:*.jpg=38;5;4:*.gif=38;5;4'

function ecw --description 'Opens up emacsclient in windowed mode'
    fish -c "emacsclient -c $argv &"
end

function ec --description 'Opens up emacsclient in terminal mode'
    # Set the title of the terminal
    echo "function fish_title; echo \"emacsclient -t $argv\"; end" | source
    # Open emacs
    fish -c "emacsclient -t $argv"
    # When done, fix up the title of the terminal
    echo "function fish_title; echo \"fish $PWD\"; end" | source
end

alias emacs-is-stuck 'pkill -SIGUSR2 emacs'

# Use emacsclient as my editor
set -gx EDITOR 'emacsclient -t'

# Set up direnv hook
direnv hook fish | source

# Load the opam env if it's installed
if type -q opam
    eval (opam config env --shell=fish)
end

# Use some safety
switch (uname)
    case Darwin
        alias rm 'rmtrash'
end

# Set the $PATH accordingly
if test -d /usr/local/sbin
    set -gx PATH $PATH /usr/local/sbin
end

if test -d $HOME/Library/Haskell/bin
    set -gx PATH $PATH $HOME/Library/Haskell/bin
end

if test -d $HOME/.local/bin
    set -gx PATH $PATH $HOME/.local/bin
end

if test -d $HOME/nodejs-bin/bin
    set -gx PATH $PATH $HOME/nodejs-bin/bin
end

if test -d $HOME/.bin
    set -gx PATH $PATH $HOME/.bin
end

# Source private file if it exists
if test -f ~/.config/fish/private.fish
    source ~/.config/fish/private.fish
end

if test -f /etc/fish/config.fish
    source /etc/fish/config.fish
end
