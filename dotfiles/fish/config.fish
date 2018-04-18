# My aliases
alias nvim  'nvim -u ~/.nvimrc'
alias bubu  'brew update ;and brew outdated ;and brew upgrade ;and brew cleanup'
alias 1pass '1pass --path $HOME/Dropbox/1Password/1Password.agilekeychain'
alias l     'ls -la'
alias la    'ls -la'
alias btc   'http https://api.cryptowat.ch/markets/kraken/btceur/summary | jq -r \'.result | .price.last\''

alias emacs-is-stuck 'pkill -SIGUSR2 emacs'

set EDITOR     'nvim'

# Set the $PATH accordingly
if test -d /usr/local/sbin
    set PATH $PATH /usr/local/sbin
end

if test -d $HOME/Library/Haskell/bin
    set PATH $PATH $HOME/Library/Haskell/bin
end

if test -d $HOME/.local/bin
    set PATH $PATH $HOME/.local/bin
end

if test -d $HOME/nodejs-bin/bin
    set PATH $PATH $HOME/nodejs-bin/bin
end

if test -d $HOME/.bin
    set PATH $PATH $HOME/.bin
end

if test -d /usr/local/opt/curl/bin/
    set PATH /usr/local/opt/curl/bin $PATH
end

set -gx LC_ALL en_US.UTF-8
set -gx LANG   en_US.UTF-8

# Hack for GVM to write some Go
if test -d $HOME/.gvm
   set go_version "go1.7"
   set GVM_ROOT "$HOME/.gvm"

   gvm use $go_version --default > /dev/null

   export GVM_ROOT
   export gvm_go_name
   export gvm_pkgset_name
   export GOROOT
   export GOPATH
   export GVM_OVERLAY_PREFIX
   export LD_LIBRARY_PATH
   export DYLD_LIBRARY_PATH
   export PKG_CONFIG_PATH

   set PATH $PATH "$GVM_ROOT/pkgsets/$go_version/global/bin"
   set PATH $PATH "$GVM_ROOT/gos/$go_version/bin"
   set PATH $PATH "$GVM_OVERLAY_PREFIX/bin"
   set PATH $PATH "$GVM_ROOT/bin"
end

# Source private file if it exists
if test -f ~/.config/fish/private.fish
    source ~/.config/fish/private.fish
end
