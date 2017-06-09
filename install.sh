#! /bin/zsh

local ZNVM_PATH="$HOME/.znvm"
local ZNVMSH_PATH="$ZNVM_PATH/znvm.sh"


# clone znvm if not in desired location
if [ ! -f $ZNVMSH_PATH ]; then
	echo "installing znvm ..."
	git clone https://github.com/Kasahs/.znvm.git $ZNVM_PATH
else
	echo "znvm already installed, updating..."
	rm -rf $ZNVM_PATH
	git clone https://github.com/Kasahs/.znvm.git $ZNVM_PATH
fi

# ensure zshrc exists at expected location
local ZSHRC_PATH="$HOME/.zshrc"

if [ ! -f $ZSHRC_PATH ]; then
	echo "ERROR: $ZSHRC_PATH doesn't exist. Aborted."
	exit 1
fi


# check if nvm is installed as expected
local NVM_PATH="$HOME/.nvm/nvm.sh"
if [ ! -f $NVM_PATH ]; then
	echo "ERROR: $NVM_PATH not found. Please check your nvm installation. Aborted."
	exit 1
fi


# source znvm.sh inside .zshrc if not already
if [ -z "$ZNVM_ACTIVE" ]; then
	echo "source $ZNVMSH_PATH" >> $ZSHRC_PATH
fi
