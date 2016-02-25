#
# Define some helpers to... help us
#

function read_list_file {
  if [[ -f $1 ]]; then
    # Cat the file, strip the lines, disregard comments, break inline comments, strip the lines again, and return as space-sparated list
    \cat $1 | \egrep -v '^\s{0,}#' | \awk -F '#' '{ print $1 }' | \sed 's/^ *//;s/ *$//' | \tr "\n" ' '
  else
    log_error "File $1 doesn't exist, what are you trying to read?"
  fi
}

#
# Get the status of previous run
#
function setup_my_mac_get_status {
  if [[ -f $SMM_DIR/status ]]; then
    \cat $SMM_DIR/status
  else
    return 1
  fi
}


#
# Set the status so we know for later runs
#
function setup_my_mac_set_status {
  if [[ -d $SMM_DIR ]]; then
    echo $1 > $SMM_DIR/status
  else
    return 1
  fi
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

