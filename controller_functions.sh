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
  for dir in $(read_list_file 'fixtures/directories.txt')
  do
    directory="${dir/HOME/$HOME}"
    log_info "Setup directory: $directory"
    mkdir -p $directory
done

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
  brew install $(read_list_file 'fixtures/brews.txt')
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
  log_warning "Do you want to install casks? [y/n]"
  read casks

  if [[ $casks == "y" || $casks == "yes" ]]; then
      log_info "Installing casks"
      brew cask update
      brew cask install $(read_list_file 'fixtures/brew_casks.txt')
      return $?
  else
      log_info "Casks skipped"
      return 0
  fi
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

  # Check if oh-my-zsh is downloaded
  if [[ ! -d $HOME/.oh-my-zsh ]]; then
    log_info "Installing oh-my-zsh"
    # Go to https://github.com/robbyrussell/oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  # Check if Vundle is installed
  if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
    log_info "Installing Vundle"
    # Install Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi

  if [[ ! -d $HOME/.config/nvim ]]; then
    log_info "Installing vim-plug"
    mkdir -p $HOME/.config/nvim
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  # TPM not installed
  if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    log_info "Installing tmux tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # Check if goobook has authenticated
  if [[ ! -f ~/.goobook_auth ]]; then
    # goobook needs to authenticate
    goobook authenticate
  fi

  # Check if my favorite theme is installed
  if [[ ! -d $HOME/.vim/bundle/dracula-theme ]]; then
    vim +PluginInstall +qall
    # I'm lazy and assuming that last thing worked but
    # we're not done, we must now patch that sumbitch
    local patchsrc=$PWD/dotfiles/vim/dracula-theme.diff
    pushd ~/.vim/bundle/dracula-theme
    git apply $patchsrc
    popd # return to original dir
  fi

  log_info "Post install commands finished"
}

#
# Does `pip install ...`
#
function install_pips {
  pip install --upgrade pip
  sudo -H pip install $(read_list_file 'fixtures/pip.txt')
  return 0 # Return as fixed in case some are already installed
}

#
# Set up my dotfiles and keep it all in order
#
function setup_dotfiles {
  log_info "Setting up your dotfiles"

  soft_link "dotfiles/ghci"                        "$HOME/.ghci"
  soft_link "dotfiles/vimrc"                       "$HOME/.vimrc"
  soft_link "dotfiles/nvimrc"                      "$HOME/.nvimrc"
  soft_link "dotfiles/emacs"                       "$HOME/.emacs"
  soft_link "dotfiles/muttrc"                      "$HOME/.muttrc"
  soft_link "dotfiles/mutt"                        "$HOME/.mutt"
  soft_link "dotfiles/msmtprc"                     "$HOME/.msmtprc"
  soft_link "dotfiles/zshrc"                       "$HOME/.zshrc"
  soft_link "dotfiles/oh-my-zsh/myusuf3.zsh-theme" "$HOME/.oh-my-zsh/themes/myusuf3.zsh-theme"
  soft_link "dotfiles/tmux"                        "$HOME/.tmux"
  soft_link "dotfiles/tmux/tmux.conf"              "$HOME/.tmux.conf"
  soft_link "dotfiles/bin"                         "$HOME/.bin"
  soft_link "dotfiles/kwmrc"                       "$HOME/.kwm/kwmrc"
  soft_link "dotfiles/fish/config.fish"            "$HOME/.config/fish/config.fish"
  soft_link "dotfiles/fish/functions"              "$HOME/.config/fish/functions"
  soft_link "dotfiles/fish/completions"            "$HOME/.config/fish/completions"


  return 0
}
