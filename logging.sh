#
# Logging functions to help in logging
# because I hate to just be 'echo'ing all
# the damn time
#

function log_info {
	echo "[INFO] $1"
}

function log_warning {
	echo "[WARN] $1"
}

function log_error {
	echo "[ERR] $1"
}
