#!/bin/bash

echo -e "\nInstalling iterm2\n"
brew install --cask iterm2

echo -e "\nInstalling Oh My Zsh - framework for managing Zsh configuration\n"
if [ -d "$HOME/.oh-my-zsh" ]; then
    rm -rf $HOME/.oh-my-zsh
fi
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
exit

echo -e "\nInstalling Powerlevel10K theme\n"
if [ -d "$HOME/powerlevel10k" ]; then
    rm -rf $HOME/powerlevel10k
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

echo -e "\nSet pre-configured p10k theme\n"
cp -f ./iterm2/.p10k.zsh ~/

echo 'if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then' >> tmp.0
echo '    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"' >> tmp.0
echo -e "fi\n\n" >> tmp.0
cat tmp.0 ~/.zshrc > tmp.1 && mv tmp.1 ~/.zshrc
rm -f tmp.0

echo >> ~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

