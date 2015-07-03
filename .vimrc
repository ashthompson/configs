set nocp
filetype off

autocmd FileType perl set smartindent
autocmd FileType css set smartindent
autocmd FileType html set smartindent
autocmd BufNewFile,BufRead *.json setf json

call pathogen#helptags()
call pathogen#infect()

filetype plugin indent on

let mapleader=","

syntax on
set bg=dark
colorscheme solarized
set t_Co=256

set number
set wildmenu
set wildmode=list:longest,full
set showcmd

set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set autoindent

set encoding=utf-8
set scrolljump=1
set scrolloff=4
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber
set undofile
"set spell
syn sync fromstart

"ctrlp
let g:ctrlp_cmd = "CtrlPMixed"
let g:ctrlp_max_files = 0
let g:ctrlp_regexp = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_follow_symlinks = 1

let g:neocomplcache_enable_at_startup = 1

set pastetoggle=<F12>

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set mouse=a
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

nnoremap ; :
au FocusLost * :wa
nnoremap <leader>a :Ack
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
inoremap jj <ESC>

set directory=/home/athompson/.vimswap
set backupdir=/home/athompson/.vimswap
set undodir=/home/athompson/.vimswap

set ignorecase
set smartcase

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplUseSingleClick = 1

"let g:Powerline_symbols = 'fancy'

let g:netrw_liststyle=3

"map <Leader>a :SlimuxShellLast<CR>
"map <C-c><C-c> :SlimuxREPLSendLine<CR>
"vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>

map <leader>c :s/^/#/<CR>:let @/=''<CR>
map <leader>C :s/^#//<CR>:let @/=''<CR>

map <silent> <leader>t :TlistToggle<CR>

map <leader>fd :chdir %:p:h<CR>

let Tlist_Compact_Format=1
let Tlist_Enable_Fold_Column=0
let Tlist_Show_Menu=1


"let g:slime_target = "tmux"
set guifont=Monospace\ 8

highlight CursorLine ctermbg=233 cterm=none

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip


function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

let g:neocomplcache_enable_cursor_hold_i = 1

