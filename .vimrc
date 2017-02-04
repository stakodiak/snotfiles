set cm=blowfish
set expandtab
set tabstop=4
set nu
set autoindent
set shiftwidth=4
set showtabline=0
set nohlsearch
syntax on
set mouse=a
set incsearch
set clipboard=unnamedplus,unnamed,exclude:cons\|linux

" shortcut for quickly changing words
map <space> ciw

" shortcut for column width
map \t :set tw=

" set tab spacing for HTML
map \h :set softtabstop=2<CR>:set shiftwidth=2<CR>

" SCSS
" Recognize dashes as valid identifier characters
augroup vimrc | execute 'autocmd!' | augroup END
autocmd vimrc FileType scss setlocal iskeyword+=-
