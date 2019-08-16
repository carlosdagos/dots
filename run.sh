#!/usr/bin/env bash

#
# This one will only sync the dotfiles
#
set -o errexit
set -o pipefail
set -o nounset

#
# Logging functions to help in logging
# because I hate to just be 'echo'ing all
# the damn time
#
function smm_log_date {
  date +%Y-%m-%d.%H:%M:%S
}

function log_info {
  echo "[$(smm_log_date)][INFO]: $1" > /dev/stderr
}

function log_warning {
  echo "[$(smm_log_date)][WARN]: $1" > /dev/stderr
}

function log_error {
  echo "[$(smm_log_date)][ERR ]: $1" > /dev/stderr
}


#
# Create soft links, unless they're
# already there
#
function soft_link {
  local src=$PWD/$1
  local lndst=$2

  # if already exists and it a link
  if [[ -L $2 ]]; then
    log_info "$2 already exists"
    return 0
  fi

  log_info "Setting up soft link $src -> $lndst"

  mkdir -p $(dirname "$lndst")
  ln -sfv "$src" "$lndst"

  if [[ ! $? -eq 0 ]]; then
    log_warning "Could not set up soft link $src -> $lndst"
    return 1
  else
    return 0
  fi
}

#
# Set up my dotfiles and keep it all in order
#
function setup_dotfiles {
  log_info "Setting up your dotfiles"

  soft_link "dotfiles/ghci"             "$HOME/.ghci"
  soft_link "dotfiles/gitconfig"        "$HOME/.gitconfig"
  soft_link "dotfiles/vimrc"            "$HOME/.vimrc"
  soft_link "dotfiles/nvimrc"           "$HOME/.nvimrc"
  soft_link "dotfiles/emacs"            "$HOME/.emacs"
  soft_link "dotfiles/muttrc"           "$HOME/.muttrc"
  soft_link "dotfiles/mutt"             "$HOME/.mutt"
  soft_link "dotfiles/msmtprc"          "$HOME/.msmtprc"
  soft_link "dotfiles/tmux"             "$HOME/.tmux"
  soft_link "dotfiles/tmux/tmux.conf"   "$HOME/.tmux.conf"
  soft_link "dotfiles/bin"              "$HOME/.bin"
  soft_link "dotfiles/termite/config"   "$HOME/.config/termite/config"
  soft_link "dotfiles/fish/config.fish" "$HOME/.config/fish/config.fish"
  soft_link "dotfiles/fish/completions" "$HOME/.config/fish/completions"
  soft_link "dotfiles/dunstrc"          "$HOME/.dunstrc"
  soft_link "dotfiles/Xdefaults"        "$HOME/.Xdefaults"
  soft_link "dotfiles/i3/config"        "$HOME/.config/i3/config"
  soft_link "dotfiles/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
  soft_link "dotfiles/rofi"             "$HOME/.config/rofi"

  return 0
}

setup_dotfiles
