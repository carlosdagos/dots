# My aliases
alias nvim  'nvim -u ~/.nvimrc'
alias l     'ls -la'
alias la    'ls -la'

set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

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

function ec --description 'Opens up emacsclient in terminal mode'
    echo "function fish_title; echo \"emacsclient -t $argv\"; end" | source
    fish -c "emacsclient -t $argv"
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

# Source private file if it exists
if test -f ~/.config/fish/private.fish
    source ~/.config/fish/private.fish
end

if test -f /etc/fish/config.fish
    source /etc/fish/config.fish
end
