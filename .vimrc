" upgrade to avoid bug
" see: https://vi.stackexchange.com/questions/364/how-secure-is-encrypting-files-with-blowfish
set cryptmethod=blowfish2

" use fzf for finding files
set runtimepath+=/opt/homebrew/opt/fzf

" avoid 'No write since last change' error
set hidden

" convert tabs to spaces

" default indentation is four spaces
set tabstop=4
set shiftwidth=4
set expandtab

" show line numbers
set number

" autoindent sucks
set nosmartindent

" show filename
set showtabline=0

" turn off highlighting when not searching
set nohlsearch

" color different parts of text
syntax on

" enable mouse control (e.g. scoll) in vim
" note: hold opt to select text normally
set mouse=a

" show where typed pattern matches when searching
set incsearch

" share system with vim clipboard
set clipboard=unnamedplus,unnamed,exclude:cons\|linux

" shortcut for setting line length
map \t :set tw=

" set tab spacing for HTML
map \h :set softtabstop=2<CR>:set shiftwidth=2<CR>

" make sure autocommands don't execute twice. does this work?
augroup vimrc | execute 'autocmd!' | augroup END

" add dashes as part of a valid keyword in css/sass
" from @staticshock
autocmd vimrc FileType scss setlocal iskeyword+=-
autocmd vimrc FileType css setlocal iskeyword+=-

" automatically reload file if vim detects a change
set autoread

" persist undo history across sessions
set undofile

" ctrl+p for finding files
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_working_path_mode = 'ra'

" keep relevant source code in home dir
set tags+=$HOME/src/tags
set tags=./tags,tags;$HOME

" from Thoughtbot - use Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" jump to the last known cursor position when opening a file
function! s:JumpToLastKnownCursorPosition()
  if line("'\"") <= 1 | return | endif
  if line("'\"") > line("$") | return | endif
  " Ignore git commit messages and git rebase scripts
  if expand("%") =~# '\v(^|[\/])\.git[\/]' | return | endif
  execute "normal! g`\"" |
endfunction
autocmd vimrc BufReadPost * call s:JumpToLastKnownCursorPosition()

" use <space> as <leader>
let mapleader = ' '

" save current file with <space> <space>
nmap <silent> <leader><leader> :update<cr><c-l>

" get list of open buffers
nnoremap <leader>b :bro ol<cr>

" remake tags for current file
nmap <leader>T :!make tags<cr><cr>

" shortcut for running Makefile commands
nnoremap <leader>m :make

" leader shortcuts are now for the quickfix
nnoremap <leader>c :20copen<cr>
nnoremap <leader>x :cclose<cr>
nnoremap <leader>n :cnext<cr>

" set encoding to avoid strange character issues (e.g. with em-dash)
" from: https://stackoverflow.com/questions/16507777/set-encoding-and-fileencoding-to-utf-8-in-vim
set encoding=utf-8 fileencoding=utf-8

" ctrl + h/j/k/l will move around the windows
" from: https://superuser.com/questions/280500/how-does-one-switch-between-windows-on-vim
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" quickly change between indentation sizes
nnoremap <leader>2 :set shiftwidth=2 tabstop=2 <cr>
nnoremap <leader>4 :set shiftwidth=4 tabstop=4 <cr>
