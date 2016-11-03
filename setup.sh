#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

#
# Main entry point for my setup
#

source controller_functions.sh

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
    brew_cleanup
    install_pips
    post_install_commands
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

  setup_my_mac_set_status $SMM_STATUS_SUCCESS
  log_info "Successfully set up your mac!"
  exit 0
}

#
# Do the actual execution
# of this simple program
#
main
