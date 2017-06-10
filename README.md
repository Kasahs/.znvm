# znvm
* Make ```zsh``` with ```nvm``` faster by loading only if ```.nvmrc``` file found or called explicitly  
* Automatically calls ```nvm use``` if ```.nvmrc``` is present.
* If node vesion in ```.nvmrv``` is not installed it will automatically call ```nvm install <node_version>``` 

### Installation - automatic

```curl -o- https://raw.githubusercontent.com/Kasahs/.znvm/master/install.sh | zsh```
open new terminal or use ```source ~/.zshrc```

### Installation - manual

```git clone https://github.com/Kasahs/.znvm.git $HOME/.znvm```  
```echo "source $HOME/.znvm/znvm.sh" >> ~/.zshrc```  
open new terminal or use ```source ~/.zshrc```


### Usage
nothing to do here ;)
* if you wish to use nvm just call it, wait for it to load and then start using it
* if you switch to a dir that has .nvmrc, nvm will automatically load and use node version specified in .nvmrc
* if node version specified in .nvmrc is not installed it will be automatically installed and used
