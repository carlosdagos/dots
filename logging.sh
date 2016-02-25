#
# Logging functions to help in logging
# because I hate to just be 'echo'ing all
# the damn time
#

function smm_log_date {
  date +%Y-%m-%d.%H:%M:%S
}

function log_info {
  echo "[$(smm_log_date)][INFO]: $1" >> smm.log
}

function log_warning {
  echo "[$(smm_log_date)][WARN]: $1" >> smm.log
  echo "[$(smm_log_date)][WARN]: $1" > /dev/stderr
}

function log_error {
  echo "[$(smm_log_date)][ERR ]: $1" >> smm.log
  echo "[$(smm_log_date)][ERR ]: $1" > /dev/stderr
}
