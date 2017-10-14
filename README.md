# znvm  
makes zsh with nvm fast and more convenient

### Features
* Make ```zsh``` with ```nvm``` faster by loading only if ```.nvmrc``` file found or called explicitly  
* Automatically calls ```nvm use``` if ```.nvmrc``` is present.
* If node vesion in ```.nvmrv``` is not installed it will automatically call ```nvm install <node_version>``` 
* Can be configured to load nvm before certain commands are executed on the shell (such as editors and IDEs)

<p> <span style="color: red">WARNING:</span> Do not install using npm. Use methods mentioned below.</p>


### Before installing
Make sure you remove or comment out the following lines from your .zshrc file
```zsh
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

### Installation - automatic

```zsh
curl -o- https://raw.githubusercontent.com/Kasahs/.znvm/master/install.sh | zsh
```
then open new terminal or use 
```zsh 
source ~/.zshrc
```

### Installation - manual
Clone the repo in $HOME
```zsh 
git clone https://github.com/Kasahs/.znvm.git $HOME/.znvm
```  
source znvm.sh in .zshrc
```zsh
echo "source $HOME/.znvm/znvm.sh" >> ~/.zshrc
```  
then open new terminal or use 
```zsh 
source ~/.zshrc
```

### Configure
open $HOME/.znvm/znvm.conf.sh in an editor
```zsh
gedit $HOME/.znvm/znvm.conf.sh
```
Add/remove items from the ZNVM_PREEXEC ARRAY
```zsh
# Add/remove items from the array given below
ZNVM_PREEXEC=("subl" "atom" "code")

# WARNING: Dont remove the ZNVM_PREEXEC variable
# leave ZNVM_PREEXEC=() to disable this feature
```

### Usage
nothing to do here its very natural ;)
* if you wish to use nvm just call it, wait for it to load and then start using it
* if you switch to a dir that has .nvmrc, nvm will automatically load and use node version specified in .nvmrc
* if node version specified in .nvmrc is not installed it will be automatically installed and used
* if you have configured ZNVM_PREEXEC then nvm will be loaded before command executes