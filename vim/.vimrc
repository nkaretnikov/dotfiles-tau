set t_Co=256
set nocompatible
set ruler
set showcmd
set confirm

" Indentation.
" https://wiki.haskell.org/Vim
set tabstop=8
set expandtab      " always use spaces instead of tabs
set softtabstop=2  " insert 2 spaces when tab is pressed
set shiftwidth=2   " an ident is 2 spaces
set shiftround     " round indent to nearest shiftwidth multiple

" Solarized.
syntax enable
set background=light
colorscheme solarized

" Spell checking.
setlocal spell spelllang=en
