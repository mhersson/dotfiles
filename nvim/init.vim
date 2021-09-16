" ==========================================================
" Plugins
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ==========================================================
if !exists('g:vscode')

    call plug#begin('~/.config/nvim/plugged')
    " Look and feel
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'arcticicestudio/nord-vim'
    Plug 'projekt0n/github-nvim-theme'
    " Fuzzy file, buffer, mru, tag, etc finder
    Plug 'ctrlpvim/ctrlp.vim'
    " Ale linting with support for language servers
    Plug 'dense-analysis/ale'
    " Go tools
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " Org mode
    Plug 'jceb/vim-orgmode'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    call plug#end()
    " ==========================================================
    " Basic Settings
    " ==========================================================
    set fileformat=unix
    syntax on                     " syntax highlighing
    set hidden                    " hide buffers instead of closing them
    filetype on                   " try to detect filetypes
    filetype plugin indent on     " enable loading indent file for filetype
    set number                    " Display line numbers
    set wildmenu                  " Menu completion in command mode on <Tab>
    set wildmode=full             " <Tab> cycles between all matching choices.

    set pumheight=10

    " don't bell or blink
    set noerrorbells
    set vb t_vb=

    """ Moving Around/Editing
    set cursorline              " have a line indicate the cursor location
    set ruler                   " show the cursor position all the time
    set nowrap                  " don't wrap text
    set linebreak               " don't wrap textin the middle of a word
    set autoindent              " always set autoindenting on
    set smartindent             " use smart indent if there is no indent file
    set tabstop=4               " <tab> inserts 4 spaces
    set shiftwidth=4            " an indent level is 4 spaces wide.
    set softtabstop=4           " <BS> over an autoindent deletes all 4 spaces.
    set expandtab               " Use spaces, not tabs, for autoindent/tab key.
    set shiftround              " rounds indent to a multiple of shiftwidth
    "set textwidth=79            " breaks line at length 79
    set nofixendofline
    set noeol

    " close preview window automatically when we move around
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    """" Reading/Writing
    set noautowrite             " Never write a file unless I request it.
    set noautowriteall          " NEVER.

    """ Searching and Patterns
    set ignorecase              " Default to using case insensitive searches,
    set smartcase               " unless uppercase letters are used in the regex.
    set smarttab                " Handle tabs more intelligently
    "set hlsearch                " Highlight searches by default.
    set incsearch               " Incrementally search while typing a /regex

    "Highlight trailing white space"
    highlight ExtraWhitespace ctermbg=red guibg=red
    au ColorScheme * highlight ExtraWhitespace guibg=red
    au BufEnter * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhiteSpace /\s\+$/

    " ===========================================================
    " Shortcuts
    " ===========================================================
    "Set Mapleader
    let mapleader = ","
    let g:mapleader = ","

    " Paste mode toggle
    set pastetoggle=<F4>

    " Move between previous and next buffers
    nmap <leader>n  :bnext<CR>
    nmap <leader>p  :bprevious<CR>

    " Open/Close Location list (display errors)
    nmap <leader>lo :lopen<CR>
    nmap <leader>lc :lclose<CR>
    nmap <leader>ln :lnext<CR>
    nmap <leader>lp :lprev<CR>

    " Command shortcuts
    nmap <leader>k :bp <BAR> bd #<CR>
    nmap <C-q> :qa<CR>


    " Show all open buffers and their status
    nmap <leader>bl :ls<CR>

    " Use CTRL-S for saving, also in Insert mode
    noremap <silent> <C-S> :update<CR>
    vnoremap <silent> <C-S> <C-C> :update<CR>
    inoremap <silent> <C-S> <C-O> <esc> :update<CR>


    " Reload Vimrc
    map <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'config reloaded'"<CR>

    " ==========================================================
    " Bash
    " ==========================================================
    " use 2 spaces in shell scripts
    autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    " ==========================================================
    " Python
    " ==========================================================
    autocmd FileType python setlocal completeopt-=preview colorcolumn=80

    " ==========================================================
    " Vim-go
    " ==========================================================
    let g:go_gopls_options = ['-remote=auto']

    let g:go_gopls_complete_unimported = 1
    " use goreturns as format tool to add/delete imports on save
    let g:go_fmt_command = "goreturns"
    let g:go_addtags_transform = "snakecase"
    " Highlight more info
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1
    " highlight same variables in view
    "let g:go_auto_sameids = 1
    "let g:go_updatetime = 300
    " show type info in statusbar
    let g:go_auto_type_info = 1
    " disable gd mapping of vim-go
    let g:go_def_mapping_enabled = 1

    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>i  <Plug>(go-install)


    " ==========================================================
    " Tagbar
    " ==========================================================
    map <leader>, :TagbarToggle<CR>
    let g:tagbar_autoclose = 1
    let g:tagbar_autofocus = 1
    let g:tagbar_show_balloon = 0

    " Special Tagbar settings for go
    let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }


    " ==========================================================
    " NERDTree
    " ==========================================================
    map <F8> :NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen=3

    " ==========================================================
    " Theme
    " ==========================================================


    set termguicolors     " enable true colors support
    colorscheme github_light

    " ==========================================================
    " Airline
    " ==========================================================
    let g:airline_theme = 'base16_one_light'
    let g:airline_powerline_fonts = 1

    " ==========================================================
    " Fugitive
    " ==========================================================
    nmap <leader>gs :Gstatus<CR>

    " ==========================================================
    " Ale
    " ==========================================================
    let g:ale_go_gopls_executable = '$GOPATH/bin/gopls'
    let g:ale_go_gopls_options = ['-remote=auto']
    let g:ale_linters = {
    \ 'go': ['golangci-lint','gopls'],
    \ 'python': ['pyls', 'pylint', 'flake8'],
    \ 'sh': ['language_server', 'shellcheck'],
    \}

    let g:ale_go_golangci_lint_options = '
    \ --enable-all
    \ --disable gochecknoglobals
    \ --disable gochecknoinits
    \ --disable gofumpt
    \ --disable gomnd
    \ --disable gci
    \ --disable exhaustivestruct'

    " As of 10.05.2020 this needs to be 1 for linting to work
    let g:ale_go_golangci_lint_package = 1

    let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['autopep8', 'reorder-python-imports',
    \ 'remove_trailing_lines', 'trim_whitespace'],
    \}
    let g:ale_fix_on_save = 1

    " Error and warning signs.
    let g:ale_sign_error = '⤫'
    let g:ale_sign_warning = '⚠'

    " Enable integration with airline.
    let g:airline#extensions#ale#enabled = 1

    let g:ale_open_list = 0

    let g:ale_set_balloons = 1

    " Navigate errors
    nmap <leader>en :ALENext<CR>
    nmap <leader>ep :ALEPrevious<CR>

    " ==========================================================
    " COC
    " ==========================================================
    " Give more space for displaying messages.
    set cmdheight=1

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=200

    " always show signcolumns
    set signcolumn=yes

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <f12> <Plug>(coc-definition)
    nmap <S-f12> <Plug>(coc-references)

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    autocmd CursorHold * silent call CocActionAsync('highlight')

    " automatically install coc extensions if they're missing
    let g:coc_global_extensions=['coc-go', 'coc-python', 'coc-snippets',
            \ 'coc-highlight', 'coc-yaml', 'coc-json', 'coc-sh', 'coc-rust-analyzer']
endif