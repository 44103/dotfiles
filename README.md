## preinstall
- curl
- git
- zsh
  ```sh
  chsh -s `which zsh`
  ```

## install

### Linux / WSL

- Normal
  ```sh
  zsh -c "`curl -L raw.github.com/44103/dotfiles/main/install.sh`"
  ```
- With preset (e.g. wsl)
  ```sh
  zsh -c "`curl -L raw.github.com/44103/dotfiles/main/install.sh`" -s wsl
  ```

### Windows

Run `windows/setup/main.bat` to apply all configurations.

```bat
windows\setup\main.bat
```

Individual scripts can also be run standalone.

```powershell
powershell -ExecutionPolicy Bypass -File windows\setup\noctty.ps1
```

## import (Windows)

To pull changes made on the Windows side back into dotfiles, run `windows/import/main.bat`.

```bat
windows\import\main.bat
```

Then review and commit the diff from WSL.

```sh
git diff
git add config/noctty/config.ghostty
git commit -m "chore: update noctty config"
```

## config

| Path | Description |
|:---|:---|
| `config/noctty/config.ghostty` | noctty (Ghostty) config |
| `config/nvim/` | Neovim config |
