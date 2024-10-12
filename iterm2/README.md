> The script `install.sh` does not achieve the desired result, so please follow the manual steps until this issue is resolved

> Install Homebrew if it is not already installed

`cd ~`
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
`echo >> .zprofile`
`echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile`
`eval "$(/opt/homebrew/bin/brew shellenv)"`

> Install iterm2

`brew install --cask iterm2`

> Install Oh My Zsh

`/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

> Install Powerlevel10k theme

`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k`
`echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc`

Now, launch iterm2 to configure the theme.

The script is primarily developed based on the information from [this tutorial](https://medium.com/jeantimex/how-to-configure-iterm2-and-vim-like-a-pro-on-macos-e303d25d5b5c).
