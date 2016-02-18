#!/bin/bash

#
# Main entry point for my
# setup 
#

source logging.sh
source constants.sh

#
# Main function 
#
function main {
	# Ordered steps to take to set up my mac
	steps=(
		setup_directories
		install_borderless_iterm
		install_brew
		install_brew_programs
		install_brew_cask
		install_brew_cask_programs
		setup_dotfiles
	)

	#
	# Just in case something went wrong before
	#
	if [[ -d $SMM_DIR && $(cat $SMM_DIR/status) == "$SMM_STATUS_ERROR" ]]; then
		log_warning "The previous run failed, you sure you want to contine? [y/n]"
		read cont

		if [[ $cont != "y" ]]; then
			exit
		fi
	fi
		

	for step in ${steps[*]}
	do
		# Call the func
		$step
		# Check exit status
		if [[ $? -gt 0 ]]; then
			setup_my_mac_set_status $SMM_STATUS_ERROR
			log_error "Cannot continue because '$step' failed!"
			break
		fi
	done

	log_info "Successfully set up your mac!"
}

#
# Let's me know what's the status
# for further runs
#
function setup_my_mac_set_status {
	if [[ -d $SMM_DIR ]]; then
		echo $1 > $SMM_DIR/status
	else 
		log_error "Tried to set status but default directory doesn't exist!"
	fi
}

#
# Sets up my basic directories
#
function setup_directories {
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
	return 0
}

#
# Sets up my favorite programs
#
function install_brew_programs {
	return 0
}

#
# Sets up my favorite package manager bis
#
function install_brew_cask {
	return 0
}

#
# Sets up my favorite casks
#
function install_brew_cask_programs {
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
