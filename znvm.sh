#! /bin/zsh 

# ensure znvm download location is correct
local ZNVM_PATH="$HOME/.znvm"
local ZNVMSH_PATH="$ZNVM_PATH/znvm.sh"

if [ ! -f $ZNVMSH_PATH ]; then
	echo "ERROR: could not find $ZNVMSH_PATH. Please ensure $ZNVM_PATH exists."
	echo "INFO: follow installation instructions as stated in the README.md file."
	echo "Aborted."
	exit 1
fi

#load main script and assign nvm alias
source "$ZNVM_PATH/loadnvmrc.sh"
