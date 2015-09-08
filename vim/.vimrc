set t_Co=256
set nocompatible
set ruler
set showcmd
set confirm
set number

" Indentation.
" https://wiki.haskell.org/Vim
set tabstop=8
set expandtab      " always use spaces instead of tabs
set softtabstop=2  " insert 2 spaces when tab is pressed
set shiftwidth=2   " an ident is 2 spaces
set shiftround     " round indent to nearest shiftwidth multiple
set autoindent     " copy the indentation from the previous line

" Delete over autoindent, line breaks, and the start of insert.
set backspace=indent,eol,start

" Solarized.
syntax enable
set background=light
colorscheme solarized

" Highlight extra whitespace.
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=lightred guibg=lightred
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Highlight search.
set hlsearch
" And get rid of it by hitting the 'Esc' key.
nnoremap <esc> :noh<return><esc>

" Spell checking.
setlocal spell spelllang=en_us

" Pathogen.
execute pathogen#infect()
syntax on
filetype plugin indent on

" Commentary.
" Recognize .nix files.
autocmd FileType nix setlocal commentstring=#\ %s

" Make shortcuts work in Cyrillic.
set keymap=russian-jcuken
set iminsert=0
set imsearch=0

" Wrap long lines.
set wrap
set textwidth=80

" Leader.
let mapleader = "\<Space>"

" Coquille.
nnoremap <Leader>n :CoqNext<return>
nnoremap <Leader>c :CoqToCursor<return>
nnoremap <Leader>u :CoqUndo<return>
