# #############################################################
# Load nvm only when called explicitly or 
# when dir contains .nvmrc file.
# 
# If .nvmrc is present 
# automatically [nvm use <node-version specified in .nvmrc>]
# #############################################################
znvm_echo() {
  command printf %s\\n "$*" 2>/dev/null || {
    znvm_echo() {
      # shellcheck disable=SC1001
      \printf %s\\n "$*" # on zsh, `command printf` sometimes fails
    }
    znvm_echo "$@"
  }
}

znvm_find_up() {
  local path
  path="${PWD}"
  while [ "${path}" != "" ] && [ ! -f "${path}/${1-}" ]; do
    path=${path%/*}
  done
  znvm_echo "${path}"
}

znvm_find_nvmrc() {
  local dir
  dir="$(znvm_find_up '.nvmrc')"
  if [ -e "${dir}/.nvmrc" ]; then
    znvm_echo "${dir}/.nvmrc"
  fi
}

load-nvm() {
	unalias nvm
	echo "loading nvm..."
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	# export NVM_LATEST_VERSION="$(ls -1 $NVM_DIR/versions/node | tail -1)"
	# export PATH=$NVM_DIR/versions/node/$NVM_LATEST_VERSION/bin:$PATH
	# export MANPATH=$NVM_DIR/versions/node/$NVM_LATEST_VERSION/share/man:$MANPATH
}


# ensure znvm download location is correct
local ZNVM_PATH="$HOME/.znvm"
local ZNVMSH_PATH="$ZNVM_PATH/znvm.sh"

if [ ! -f $ZNVMSH_PATH ]; then
	echo "ERROR: Could not find $ZNVMSH_PATH. Please ensure $ZNVM_PATH exists."
	echo "INFO: Follow installation instructions as stated in the README.md file."
	exit 1
fi

source "$ZNVM_PATH/loadnvmrc.sh"
alias nvm='load-nvm'
