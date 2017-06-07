#! /bin/zsh

# if .znvm/ not found clone it
if [ ! -d "$HOME/.znvm" ]; then
	cd $HOME
	git clone https://github.com/Kasahs/.znvm.git
fi

# ensure znvm download location is correct
local ZNVM_PATH="$HOME/.znvm"
local ZNVMSH_PATH="$ZNVM_PATH/znvm.sh"

if [ ! -f $ZNVMSH_PATH ]; then
	echo "ERROR: Could not find $ZNVMSH_PATH. Please ensure $ZNVM_PATH exists."
	echo "INFO: Follow installation instructions as stated in the README.md file."
	exit 1
fi

# ensure zshrc exists at expected location
local ZSHRC_PATH="$HOME/.zshrc"

if [ ! -f $ZSHRC_PATH ]; then
	echo "$ZSHRC_PATH does't exist. Aborting"
	exit 1
fi

# check if nvm is installed as expected
local NVM_PATH="$HOME/.nvm/nvm.sh"
echo $NVM_PATH
if [ ! -f $NVM_PATH ]; then
	echo "WARNING: nvm.sh was not found at $NVM_PATH"
fi

# source znvm.sh inside .zshrc
echo "source $ZNVMSH_PATH" >> $ZSHRC_PATH
