#!/bin/sh

if ! [ -d "$HOME/.vim/spell" ]; then
    mkdir -p $HOME/.vim/spell
    echo "Downloading spell files"
    curl 'http://ftp.nluug.nl/vim/runtime/spell/pl.utf-8.spl' -L -o "$HOME/.vim/spell/pl.utf-8.spl"
fi

