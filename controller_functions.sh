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
  log_info "Setting up your favorite directories"
  # First make this program's directory
  mkdir -p $SMM_DIR
  # Then make all the rest of the stuff
  mkdir -p "$(read_list_file 'fixtures/directories.txt')"
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
  # Get me my dupes
  brew tap homebrew/dupes
  brew update
  brew install "$(read_list_file 'fixtures/brews.txt')"
  return 0 # Dupes will sometimes return status 1.. so fixed for now
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
  brew cask install "$(read_list_file 'fixtures/brew_casks.txt')"
  return $?
}

#
# Perform cleanup at the end
# in case of updated programs
#
function brew_cleanup {
  brew cleanup
  brew cask cleanup
  return 0
}

#
# Some commands for post install
#
function post_install_commands {
  log_info "Running post-install commands"

  # Set up zsh as shell for my user
  if [[ $SHELL != "/bin/zsh" ]]; then
    log_info "Setting ZSH as main shell"
    chsh -s /bin/zsh
    sudo chsh -s /bin/zsh
  fi

  if [[ ! -d ~/.oh-my-zsh ]]; then
    log_info "Installing oh-my-zsh"
    # Go to https://github.com/robbyrussell/oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    log_info "Installing Vundle"
    # Install Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi

  log_info "Post install commands finished"
}

#
# Does `pip install ...`
#
function install_pips {
  pip install "$(read_list_file 'fixtures/pip.txt')"
  return 0 # Return as fixed in case some are already installed
}

#
# Set up my dotfiles and keep it all in order
#
function setup_dotfiles {
  log_info "Setting up your dotfiles"

  soft_link "dotfiles/ghci" "$HOME/.ghci"


  soft_link "dotfiles/vimrc" "$HOME/.vimrc" 

  return 0
}
