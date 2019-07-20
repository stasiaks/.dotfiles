" Vundle section
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

" -----------------------------

syntax on

set number
set statusline+=%#warningmsg#
set statusline+=%*

" Airline

let g:airline_theme='deus'

" Language specific

autocmd FileType haskell setlocal expandtab

" Keybinds

inoremap kj <Esc>
