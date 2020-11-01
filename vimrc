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
Plugin 'lervag/vimtex'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

" -----------------------------

syntax on

set number
set statusline+=%#warningmsg#
set statusline+=%*

" Language specific

autocmd FileType haskell setlocal expandtab

" Vimtex

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:texconceal='abdmg'
hi clear Conceal
" Ultisnips

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

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
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
