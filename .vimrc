execute pathogen#infect()

syntax on
filetype plugin indent on

set number
set statusline+=%#warningmsg#
set statusline+=%*

let g:airline_theme='deus'

autocmd FileType haskell setlocal expandtab
