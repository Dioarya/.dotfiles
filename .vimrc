" Set compatibility to Vim only
set nocompatible

" Don't automatically wrap text that goes beyond the width of the screen.
set nowrap

" Encoding
set encoding=utf-8

" Show line number
" Using numbertoggle https://jeffkreeftmeijer.com/vim-number/
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Auto reload when file changes on disk
" let autoreadargs={'autoread':1}
" execute WatchForChanges("*",autoreadargs)

" Status bar
set laststatus=2

" Show queued keys as they are pressed
set showcmd

" Fix backspace
set backspace=2

" Set tab width to 4
set tabstop=4
set shiftwidth=4
" Indent using spaces
set expandtab
" Removes indents on empty lines.
set autoindent
set smartindent

" Maximum number of lines the cursor can be from the top or bottom of the
" screen while there is more text to scroll into.
set scrolloff=10

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <silent> <s-n> :tabnew<CR>
nmap <silent> <s-m> :tabnext<CR>
nmap <silent> <s-b> :tabprevious<CR>

" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : \"\<CR>"

" ':help fo-table' for more information
set formatoptions=cqjm

call plug#begin()

if 1
    Plug 'LunarWatcher/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    let g:airline_powerline_fonts = 1
    Plug 'sheerun/vim-polyglot'
    " Plug 'scrooloose/syntastic'
    Plug 'dense-analysis/ale'
    " Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
    " let g:coc_compile_commands = 'g++'
    " let g:coc_compile_args = ['-Wall']
    Plug 'godlygeek/tabular'
    Plug 'vim-scripts/LargeFile'
    Plug 'mbbill/undotree'
    nnoremap <F5> :UndotreeToggle<CR>
    Plug 'tomasiser/vim-code-dark'
    Plug 'flazz/vim-colorschemes'
    Plug 'wojciechkepka/vim-github-dark'
endif

call plug#end()

let g:ale_cpp_cc_executable  = 'g++'
let g:ale_cpp_cc_options     = '-std=c++23 -Wall -Werror -Wextra -Wshadow -Weffc++ -pedantic'
let g:ale_c_cc_executable    = 'gcc'
let g:ale_c_cc_options       = '-std=c23 -Wall -Werror -Wextra -Wshadow -Weffc -pedantic'
let g:ale_linters            = { 'cpp': [ 'g++' ], 'c': [ 'gcc' ] }
let g:ale_completion_enabled = 1
let g:ale_ling_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0


set t_Co=256
set t_Ut=
colorscheme codedark
