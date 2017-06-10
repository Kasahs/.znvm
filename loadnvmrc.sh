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
	# if nvm command is present nvm is ready no need to load
	if [[ $(command -v nvm) == "nvm" ]]; then
		echo "nvm is ready"
	else
		# unalias nvm if alias exists
		[ `alias | grep nvm | wc -l` != 0 ] && unalias nvm

		echo "loading nvm..."
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi
}


autoload -U add-zsh-hook
load-by-nvmrc() {
	# if current dir has .nvmrc and nvm has not been loaded
	# load nvm
	local NVMRC_PATH="$(znvm_find_nvmrc)"
	if [ -n "$NVMRC_PATH" ] && [[ ! $(command -v nvm) == "nvm" ]]; then
		load-nvm
	fi

	#ensure nvm has loaded
	if [ -n "$NVM_DIR" ]; then

		local NODE_VERSION="$(nvm version)"

		if [ -n "$NVMRC_PATH" ]; then
			local NVMRC_NODE_VERSION=$(nvm version "$(cat "${NVMRC_PATH}")")

			if [ "$NVMRC_NODE_VERSION" = "N/A" ]; then
				nvm install
			elif [ "$NVMRC_NODE_VERSION" != "$NODE_VERSION" ]; then
				nvm use
			fi
		elif [ "$NODE_VERSION" != "$(nvm version default)" ]; then
			echo "Reverting to nvm default version"
			nvm use default
		fi
	fi
}
add-zsh-hook chpwd load-by-nvmrc

alias nvm='load-nvm'