#!/bin/bash

#
# Main entry point for my setup
#

source logging.sh
source constants.sh
source helpers.sh

#
# Main function 
#
function main {
  # Ordered steps to take to set up my mac
  steps=(
    setup_directories
    install_borderless_iterm
    install_brew
    install_brew_cask
    install_brew_cask_programs
    install_brew_programs
    setup_dotfiles
  )

  # Just in case something went wrong before
  if [[ $(setup_my_mac_get_status) == "$SMM_STATUS_ERROR" ]]; then
    log_warning "The previous run failed, you sure you want to contine? [y/n]"
    read cont

    if [[ $cont != "y" && $cont != "yes" ]]; then
      exit
    fi
  fi

  # Go step by step
  for step in ${steps[*]}
  do
    # Call the func
    $step
    # Check exit status
    if [[ $? -gt 0 ]]; then
      setup_my_mac_set_status $SMM_STATUS_ERROR
      log_error "Cannot continue because '$step' failed!"
      exit 1
    fi
  done

  log_info "Successfully set up your mac!"
  exit 0
}

#
# Sets up my basic directories
#
function setup_directories {
  log_info "Setting up your favorite directories..."
  mkdir -p $SMM_DIR
  return 0
}

#
# Sets up my favorite flavor of iTerm
#
function install_borderless_iterm {
  return 0
}

#
# Sets up my favorite package manager
#
function install_brew {
  $SMM_INSTALL_HOMEBREW 2> $SMM_LOGFILE # Send error output to log
  local brew_installed_dir=$(which brew 2> /dev/null) # Just check that it's installed
  if [[ $? -eq 0 ]]; then
    log_info "Brew installed to $brew_installed_dir"
    return 0
  else
    return 1
  fi
}

#
# Sets up my favorite programs
#
function install_brew_programs {
  # brew install $(read_list_file "fixtures/brews.txt")
  # return $?
  return 0
}

#
# Sets up my favorite package manager bis
#
function install_brew_cask {
  $SMM_INSTALL_HOMEBREW_CASK
  return 0
}

#
# Sets up my favorite casks
#
function install_brew_cask_programs {
  # brew cask install $(read_list_file "fixtures/brew_casks.txt")
  # return $?
  return 0
}

#
# Set up my dotfiles and keep it all in order
#
function setup_dotfiles {
  return 0
}

#
# Do the actual execution
# of this simple program
#
main
