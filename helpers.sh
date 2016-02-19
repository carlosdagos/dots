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
