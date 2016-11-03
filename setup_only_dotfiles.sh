#
# This one will only sync the dotfiles
#
set -o errexit
set -o pipefail
set -o nounset

source controller_functions.sh

setup_dotfiles
