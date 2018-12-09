# My aliases
alias nvim 'nvim -u ~/.nvimrc'
alias bubu 'brew update ;and brew outdated ;and brew upgrade ;and brew cleanup'
alias 1pass '1pass --path $HOME/Dropbox/1Password/1Password.agilekeychain'
alias l 'ls -la'
alias la 'ls -la'
alias btc 'http https://api.cryptowat.ch/markets/kraken/btceur/summary | jq -r \'.result | .price.last\''
alias ec 'emacsclient -t'

function ecw --description 'Opens up emacsclient in windowed mode'
    fish -c "emacsclient -c  \\
                         -e '(progn
                               (require \'seq)
                               (let ((files (seq-filter (lambda (arg) (not (string-prefix-p \"-\" arg)))
                                                        (split-string \"$argv\" \" \"))))
                                 (set-frame-font \"Envy Code R-9\")
                                 (tool-bar-mode -1)
                                 (loop for file in files
                                       do (find-file file))))' &"
end

alias emacs-is-stuck 'pkill -SIGUSR2 emacs'

# Use emacsclient as my editor
set -gx EDITOR 'emacsclient -t'

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

if test -d /usr/local/opt/curl/bin/
    set -gx PATH /usr/local/opt/curl/bin $PATH
end

set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

# Hack for GVM to write some Go
if test -d $HOME/.gvm
    set go_version "go1.7"
    set GVM_ROOT "$HOME/.gvm"

    gvm use $go_version --default >/dev/null

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

if test -f /etc/fish/config.fish
    source /etc/fish/config.fish
end
