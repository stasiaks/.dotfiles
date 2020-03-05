" Vundle section
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bkad/camelcasemotion'

call vundle#end()
filetype plugin indent on

" -----------------------------

syntax on

set number
set statusline+=%#warningmsg#
set statusline+=%*

" Language specific

autocmd FileType haskell setlocal expandtab

" Airline

let g:airline_theme='deus'

" CamelCaseMotion

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Keybinds

inoremap kj <Esc>
