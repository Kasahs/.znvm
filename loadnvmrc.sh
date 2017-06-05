autoload -U add-zsh-hook
load-nvmrc() {
	# if current dir has .nvmrc and nvm has not been loaded
	# load nvm
	local NVMRC_PATH="$(znvm_find_nvmrc)"
	if [ -n "$NVMRC_PATH" ] && [ -z "$NVM_DIR" ]; then
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
add-zsh-hook chpwd load-nvmrc
