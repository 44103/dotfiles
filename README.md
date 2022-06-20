
## preinstall
- curl
- git
- zsh
  ```sh
  chsh -s `which zsh`; exec `which zsh` -l
  ```

## install
```sh
zsh -c "$(curl -L raw.github.com/44103/dotfiles/main/install.sh)"
```
