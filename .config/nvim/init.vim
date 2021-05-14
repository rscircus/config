" vim:fdm=marker
" A good engineer invests time in crafting his tools.
"
" Author: Roland Siegbert <roland@siegbert.info>

"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugins: {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#begin('~/.config/nvim/plugged')

"" UI:

" color themes
Plug 'rscircus/acme-colors'
Plug 'robertmeta/nofrils'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" IDE:

" Rainbow Parentheses
Plug 'luochen1990/rainbow'

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

" Formatter
Plug 'Chiel92/vim-autoformat'

" Tagbar - document outline
Plug 'preservim/tagbar'

" Git
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-gh-line'
Plug 'jreybert/vimagit'
Plug 'mhinz/vim-signify'

" Syntastic
Plug 'scrooloose/syntastic'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-update-rc' }
Plug 'junegunn/fzf.vim'

" Search and replace over many files
Plug 'brooth/far.vim'

" Async make
Plug 'neomake/neomake'

" File tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " ... and git

" Tmux interop
Plug 'christoomey/vim-tmux-navigator'

" Show trailing and out of place whitespace
Plug 'ntpeters/vim-better-whitespace'

" Scroll position
Plug 'flebel/vim-scroll-position'

" Highlight yank
Plug 'machakann/vim-highlightedyank'

"" Writing:

" Tranquility
Plug 'junegunn/goyo.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'plasticboy/vim-markdown'

" JSON front matter highlight plugin
Plug 'elzr/vim-json'

"" Language Specific:

" nim-lang.org
Plug 'alaviss/nim.nvim'

" go-lang
Plug 'fatih/vim-go'

call plug#end()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" }}} Plugins
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Basic Settings: {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" colorscheme
let base16colorspace=256
"colorscheme base16-one-light
"colorscheme base16-ia-light
"colorscheme acme
set background=light
let g:gruvbox_italic=1
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox

" I like green comments
hi Comment guifg=#339933

" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

" TODO: old love...
"color acme


" Junk
syntax on
set cursorline " highlight cursorline
set encoding=utf-8 nobomb " BOM sucks
set splitright                " split windows always vertically
set mouse=a                   " respect the mouse
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter`
set showmatch                   " show matches
set gdefault                    " replacing globally is default
set incsearch                   " incremental searching
set hlsearch
set number                    " show current line number on the left
set relativenumber            " show all other line numbers relative
set autoindent " keep indent from line to line
set expandtab " Expand tabs to spaces
set backspace=indent,eol,start
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words

" Handling Undo/Backup/Swap: {{{
" Create ~/.config/nvim/files if not existing
if exists('*mkdir') && !isdirectory($HOME.'/.config/nvim/files')
  call mkdir($HOME.'/.config/nvim/files')
  call mkdir($HOME.'/.config/nvim/files/backup')
  call mkdir($HOME.'/.config/nvim/files/undo')
  call mkdir($HOME.'/.config/nvim/files/info')
endif

if has('persistent_undo')
    set undofile             " creates a <FILENAME>.un~ for eternal editing
    set undolevels=1000
    set undodir=$HOME/.config/nvim/files/undo/
    set undoreload=10000
endif

set backup
set backupdir   =$HOME/.config/nvim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set noswapfile " because there is git
" }}}

" ignore a bunch of files
set wildmode=list:longest,list:full       " show all
set wildignore+=*.a,*.o
set wildignore+=*.mod "Fortran
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store
set wildignore+=*~,*.swp,*.tmp
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX

silent! helptags ALL          " Generate help tags automatically

" Integrated Terminal configuration
"
" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <leader>:call OpenTerminal()<CR>

" Speed up transition from modes
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" Word Processor Mode
augroup word_processor_mode
  autocmd!

  function! WordProcessorMode() " {{{
    setlocal formatoptions=t1
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_ca
    setlocal noexpandtab
    setlocal wrap
    setlocal linebreak
    Goyo 100
  endfunction " }}}
  com! WP call WordProcessorMode()
augroup END

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" }}} Basic Settings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Keyboard Shortcuts: {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let mapleader = ","
let maplocalleader = "\<Space>"

" Navigate visual lines instead of logical ones
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^

" Curosorline
":hi CursorLine ctermbg=white guibg=white cterm=none gui=none
:nnoremap <leader>H :set cursorline!<CR>

" Edit this file
nnoremap <leader>rc <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>lrc <C-w><C-v><C-l>:e ~/.vimrc_local<cr>

" Window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Strip trailing whitespace
nmap <leader>tw :StripWhitespace<cr>

" Switch between various tab-expansions
:nmap <leader>t4 :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <leader>tc :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap <leader>t8 :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap <leader>t2 :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" Insert timestamp
nmap <F7> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
imap <F7> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
smap <F7> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" Highlight/Unhighlight search
nmap <leader>h :set nohlsearch!<cr>
noremap / /\v
vnoremap / /\v

" Speed up viewport scroll
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>`

noremap <leader>W :w !sudo tee %<CR> " sudo write

map <leader>qq :cclose<CR> " close quickfix window

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" }}} Keyboard Shortcuts
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugins Settings: {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"

"" Rainbow:
let g:rainbow_active = 1  "or :RainbowToggle

"" FZF:
"let g:fzf_preview_window = ['right:50', 'ctrl-/']

"" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>1 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>1 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <c-p> :Files<cr>

"" Neomake:
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)


"" NERDTree:
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<cr>
map <leader>nf :NERDTreeFind<cr>
"let g:NERDTreeDirArrowExpandable = ''
"let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeWinSize = 35
let g:NERDTreeGitStatusWithFlags = 1

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && expand('%:e') == '.git/COMMIT_EDITMSG' && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Close NERDTree if it is the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"" Tagbar
nmap <leader>t :TagbarToggle<CR>

"" TmuxNavigator:
let g:tmux_navigator_save_on_switch = 2
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>


"" Markdown:
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" vim-autoformat
noremap <F3> :Autoformat<CR>

" NCM2
augroup NCM2
  autocmd!

  " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
  " found' messages
  set shortmess+=c

  " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
  inoremap <c-c> <ESC>

  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new
  " line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

  " Use <TAB> to select the popup menu:
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect

  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

  " Don't flicker in my face too much
  let g:ncm2#complete_delay=180 "delay in ms

  " uncomment this block if you use vimtex for LaTex
  " autocmd Filetype tex call ncm2#register_source({
  "           \ 'name': 'vimtex',
  "           \ 'priority': 8,
  "           \ 'scope': ['tex'],
  "           \ 'mark': 'tex',
  "           \ 'word_pattern': '\w+',
  "           \ 'complete_pattern': g:vimtex#re#ncm2,
  "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
  "           \ })
augroup END

"" Airline:
let g:airline_theme='sol'
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

"" Syntastic.vim: {{{
augroup syntastic_config
  autocmd!
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_ruby_checkers = ['mri', 'rubocop']
augroup END
" }}}

"" Signify:
set updatetime=100

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" }}} Plugins Settings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

