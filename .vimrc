set cm=blowfish
set hidden
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

" shortcut for column width
map \t :set tw=

" set tab spacing for HTML
map \h :set softtabstop=2<CR>:set shiftwidth=2<CR>

" SCSS
" Recognize dashes as valid identifier characters
augroup vimrc | execute 'autocmd!' | augroup END
autocmd vimrc FileType scss setlocal iskeyword+=-

" from @staticshock:
" use <space> as <leader> instead of '\'
let mapleader = ' '

" save current buffer
nmap <silent> <leader><leader> :update<cr><c-l>

nnoremap <leader>b :bro ol<cr>

set autoread

" make a backup before overwriting a file
set backup

" persist undo history across sessions
set undofile

" ctrl+p for finding files
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_working_path_mode = 'ra'


set tags+=$HOME/src/tags
set tags+=$HOME/newsela/tags
nmap <leader>T :!make tags<cr><cr>

" Jump to the last known cursor position when opening a file, unless the
" position is invalid, or we're inside an event handler (happens when dropping
" a file on gvim), or when jumping to the first line, or when opening
" gitcommit or gitrebnmap <leader>T :!make tags<cr><cr>ase buffers.
function! s:JumpToLastKnownCursorPosition()
  if line("'\"") <= 1 | return | endif
  if line("'\"") > line("$") | return | endif
  " Ignore git commit messages and git rebase scripts
  if expand("%") =~# '\v(^|[\/])\.git[\/]' | return | endif
  execute "normal! g`\"" |
endfunction

autocmd vimrc BufReadPost * call s:JumpToLastKnownCursorPosition()
