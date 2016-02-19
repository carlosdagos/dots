#
# Define the main controller functions
#

source logging.sh
source constants.sh
source helpers.sh

#
# Sets up my basic directories
#
function setup_directories {
  log_info "Setting up your favorite directories..."
  # First make this program's directory
  mkdir -p $SMM_DIR
  # Then make all the rest of the stuff
  mkdir -p $(read_list_file "fixtures/directories.txt")
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
  log_info "Installing brews"
  brew update
  brew install $(read_list_file "fixtures/brews.txt")
  return $?
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
  log_info "Installing casks"
  brew cask update
  brew cask install $(read_list_file "fixtures/brew_casks.txt")
  return $?
}

#
# Perform cleanup at the end
# in case of updated programs
#
function brew_cleanup {
  brew cleanup
  brew cask cleanup
}

#
# Set up my dotfiles and keep it all in order
#
function setup_dotfiles {
  return 0
}
