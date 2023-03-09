" hide status bar
set laststatus=0
" sync system clipboard with nvim
set clipboard=unnamed


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

" don't give me that sass about json with comments
autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc  

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

" use colors in terminal
" from: https://www.sglavoie.com/posts/2019/01/16/using-embedded-terminals-inside-neovim/
set termguicolors 

" open terminals in vertical split
" from:  https://www.reddit.com/r/neovim/comments/ezt2cu/comment/fgqcu3c/
command! Term vs<bar>term

" automatically start in insert mode when opening terminals
autocmd TermOpen term://* startinsert

" ctrl+p for finding files
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_working_path_mode = 'ra'

" keep relevant source code in home dir
set tags+=$HOME/src/tags
set tags=./tags,tags;$HOME

" end suffering on latam keyboards
inoremap ¿ `
nnoremap ¿ `

" use tab to shift indentation
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>

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
" Fix backspace indent
set backspace=indent,eol,start

filetype plugin indent on
syntax on
if &compatible
  set nocompatible               " Be iMproved
endif
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" These three are required for Mason. 
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Vim startify. This is for the boot menu.
Plug 'mhinz/vim-startify'

" CtrlP for viewing files.
Plug 'ctrlpvim/ctrlp.vim'

" Testing neo tree. , + f to see.
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" Setting up autocompletion.
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

" For showing an outline
" Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'simrat39/symbols-outline.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'navarasu/onedark.nvim'

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"
" Theme Configuration
lua << EOF



require'nvim-treesitter.configs'.setup {
  highlight = {
    enabled = true
  }
}
require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('onedark').load()
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require("symbols-outline").setup {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "module", hl = "TSNamespace"},
    Namespace = {icon = "Namespace", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "C", hl = "TSType"},
    Method = {icon = "m", hl = "TSMethod"},
    Property = {icon = ".p", hl = "TSMethod"},
    Field = {icon = ".f", hl = "TSField"},
    Constructor = {icon = "C()", hl = "TSConstructor"},
    Enum = {icon = "E", hl = "TSType"},
    Interface = {icon = "I", hl = "TSType"},
    Function = {icon = "f", hl = "TSFunction"},
    Variable = {icon = "v", hl = "TSConstant"},
    Constant = {icon = "c", hl = "TSConstant"},
    String = {icon = "s", hl = "TSString"},
    Number = {icon = "n", hl = "TSNumber"},
    Boolean = {icon = "b", hl = "TSBoolean"},
    Array = {icon = "a", hl = "TSConstant"},
    Object = {icon = "o", hl = "TSType"},
    Key = {icon = "k", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "event", hl = "TSType"},
    Operator = {icon = "op", hl = "TSOperator"},
    TypeParameter = {icon = "p", hl = "TSParameter"}
  }
}
EOF
nmap <leader>n <SymbolOutline>

syntax enable
set background=dark

" Map <leader> to `,`
let mapleader=','

" Keybindings
nmap <leader>r <Plug>(coc-rename)
nmap <silent> <leader>s <Plug>(coc-fix-current)
nmap <silent> <leader>S <Plug>(coc-codeaction)
nmap <silent> <leader>a <Plug>(coc-diagnostic-next)
nmap <silent> <leader>A <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>g :call CocAction('doHover')<CR>
nmap <silent> <leader>u <Plug>(coc-references)
nmap <silent> <leader>p :call CocActionAsync('format')<CR>

" Outline
nmap <silent> <leader>f :Neotree<CR>
nmap <silent> <leader>o :SymbolsOutline<CR>

lua require('lspconfig').elmls.setup{}
lua require("mason").setup()
lua require("mason-lspconfig").setup()



" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
lua << EOF
-- Mappings.
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- this part is telling Neovim to use the lsp server
local servers = { 'pyright', 'tsserver', 'jdtls' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
    }
end

-- this is for diagnositcs signs on the line number column
-- use this to beautify the plain E W signs to more fun ones
local signs = { Error = "? ", Warn = "? ", Hint = "? ", Info = "? " } 
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end
EOF


" enable autocompletion with nvim-cmp
set completeopt=menu,menuone,noselect

" lua <<EOF
"   -- Setup nvim-cmp.
"   local cmp = require'cmp'
" 
"   cmp.setup({
"     snippet = {
"       -- REQUIRED - you must specify a snippet engine
"       expand = function(args)
"         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
"         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
"         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
"         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
"       end,
"     },
"     window = {
"       -- completion = cmp.config.window.bordered(),
"       -- documentation = cmp.config.window.bordered(),
"     },
"     mapping = cmp.mapping.preset.insert({
"       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
"       ['<C-f>'] = cmp.mapping.scroll_docs(4),
"       ['<C-Space>'] = cmp.mapping.complete(),
"       ['<C-e>'] = cmp.mapping.abort(),
"       ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
"     }),
"     sources = cmp.config.sources({
"       { name = 'nvim_lsp' },
"       { name = 'nvim_lsp_signature_help' },
"       { name = 'vsnip' }, -- For vsnip users.
"       -- { name = 'luasnip' }, -- For luasnip users.
"       -- { name = 'ultisnips' }, -- For ultisnips users.
"       -- { name = 'snippy' }, -- For snippy users.
"     }, {
"       { name = 'buffer' },
"     })
"   })
" 
"   -- Set configuration for specific filetype.
"   cmp.setup.filetype('gitcommit', {
"     sources = cmp.config.sources({
"       { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
"     }, {
"       { name = 'buffer' },
"     })
"   })
" 
"   -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
"   cmp.setup.cmdline('/', {
"     mapping = cmp.mapping.preset.cmdline(),
"     sources = {
"       { name = 'buffer' }
"     }
"   })
" 
"   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
"   cmp.setup.cmdline(':', {
"     mapping = cmp.mapping.preset.cmdline(),
"     sources = cmp.config.sources({
"       { name = 'path' }
"     }, {
"       { name = 'cmdline' }
"     })
"   })
" 
"   -- Setup lspconfig.
"   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"   -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
" EOF
" 
" Change Startupify screen
let g:startify_custom_header = ''

