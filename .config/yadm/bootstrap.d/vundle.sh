#!/bin/sh

if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo "Downloading Vundle"	
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

if ! [ -d "$HOME/.vim/bundle/coc.nvim/build" ]; then
    cd $HOME/.vim/bundle/coc.nvim
    yarn install
    cd -
fi
