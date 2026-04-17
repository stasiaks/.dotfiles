#!/bin/sh

if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo "Downloading Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

