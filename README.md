
## preinstall
- curl
- git
- zsh
  ```sh
  chsh -s `which zsh`
  ```

## install
- Normal
   ```sh
   zsh -c "`curl -L raw.github.com/44103/dotfiles/main/install.sh`"
   ```
- With Option(s) (e.g. desktop)
   ```sh
   zsh -c "`curl -L raw.github.com/44103/dotfiles/main/install.sh`" -s desktop
   ```
