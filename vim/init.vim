" Environment {
  " Basic {
    set nocompatible
    set number
    set relativenumber
    set hidden
    set wildmenu
    set autoread
    set autowrite
    set autochdir
    set showmatch
    set ignorecase
    set smartcase
    set ruler
    set hlsearch
    set incsearch
    set title
    set visualbell
    set noerrorbells
    set nobackup
    set noswapfile
    set modeline
    filetype off
    syntax enable
    filetype indent on
    filetype plugin on
    syntax on
    let mapleader=","
    set mouse=a
    set nrformats-=octal
    set winaltkeys=no
    set laststatus=2
    set history=1000
    set undolevels=1000
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set fileformat=unix
    set completeopt=longest,menu
    set backspace=indent,eol,start
    set clipboard+=unnamedplus
  " }

  " Tab & Indent {
    set autoindent
    set copyindent
    set smartindent
    set cindent
    set smarttab
    set expandtab
    set tabstop=2
    set shiftwidth=2
  " }

  " Folding {
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set foldlevel=99
    set nofoldenable
  " }

  " Codecs {
    set encoding=utf-8
    set fileencodings=utf-8,ucs-bom,gbk,gb18030,utf-16,big5

    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
  "}
" }

 " Emacs Emulating {
    " Simple navigation and editing key bindings from emacs, for Vim.
    " Inspired by a much more comprehensive plugin: Vimacs, by Andre Pang.

    function! s:home()
      let start_col = col('.')
      normal! ^
      if col('.') == start_col
        normal! 0
      endif
      return ''
    endfunction

    function! s:kill_line()
      let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
      if len(text_after_cursor) == 0
        normal! J
      else
        call setline(line('.'), text_before_cursor)
      endif
      return ''
    endfunction

    function! s:split_line_text_at_cursor()
      let line_text = getline(line('.'))
      let text_after_cursor  = line_text[col('.')-1 :]
      let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
      return [text_before_cursor, text_after_cursor]
    endfunction

    inoremap <silent> <Plug>emacs_home <C-o>:call <SID>home()<CR>
    inoremap <silent> <Plug>emacs_kill_line <C-r>=<SID>kill_line()<CR>
    inoremap <silent> <Plug>emacs_delete_word_forwards  <C-o>de
    inoremap <silent> <Plug>emacs_delete_word_backwards <Space><Left><C-o>db<Del>

    " on macvim, use option as meta key
    if has("mac")
      set macmeta
    endif

    " Insert mode
    imap <C-b> <Left>
    imap <C-f> <Right>
    imap <C-a> <Plug>emacs_home
    imap <C-e> <End>
    imap <C-n> <Down>
    imap <C-p> <Up>
    imap <M-b> <C-o>b
    imap <M-f> <C-o>e<Right>
    imap <M-a> <C-o>{
    imap <M-e> <C-o>}
    imap <C-d> <Del>
    imap <C-h> <BS>
    imap <M-d> <Esc>dwi
    imap <C-k> <Plug>emacs_kill_line
    imap <C-x><C-s> <Esc>:w<Cr>a
    imap <C-x><C-u> <Esc>ua
    imap <C-x><C-f> <Esc>:e<Space>

    " Command line mode
    cmap <C-p> <Up>
    cmap <C-n> <Down>
    cmap <C-b> <Left> cmap <C-f> <Right>
    cmap <C-a> <Home>
    cmap <C-e> <End>
    cmap <M-f> <S-Right>
    cmap <M-b> <S-Left>
    cmap <M-a> <Home>
    cmap <M-e> <End>
    cnoremap <C-d> <Del>
    cnoremap <C-h> <BS>
    cnoremap <M-h> <C-w>
    cnoremap <M-d> <C-f>de<C-c>
    cnoremap <C-k> <C-f>D<C-c><End>
  " }

" Plugins And Settings {
  " Install vim-plug if not found
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif

  call plug#begin('~/.local/share/nvim/plugged')
  " Plugins {
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'easymotion/vim-easymotion'
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'godlygeek/tabular'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'preservim/nerdtree'
    Plug 'dense-analysis/ale'
    Plug 'luochen1990/rainbow'
    Plug 'andymass/vim-matchup'
    Plug 'terryma/vim-expand-region'
    Plug 'preservim/tagbar'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'thinca/vim-quickrun'
    Plug 'tpope/vim-fugitive'
    Plug 'mileszs/ack.vim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'google/vim-searchindex'
    Plug 'morhetz/gruvbox'
    Plug 'mtth/scratch.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
  " }
  call plug#end()

  " Bundles Setting {
  
  " TagBar
    map <silent> <leader>l :TagbarToggle<cr>
  
  " NERDTree
    map <silent> <leader>n :NERDTreeToggle<cr>

    " Vim Powerline
    let g:Powerline_symbols='fancy'
    let g:airline_powerline_fonts = 1
    let g:airline_theme='gruvbox'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'
    let g:airline_section_b = '%{getcwd()}'
    let g:airline#extensions#tabline#fnamemod = ':t'
" }

" Appearance {
  set termguicolors
  set cursorline
  set wrap
  set linebreak
  set nolist
  if has("mac")
    set guifont=Fira\ Mono\ for\ Powerline:h14
  elseif has("win32") || has("win64")
    set guifont=Fira\ Mono\ for\ Powerline:h14
  elseif has("unix")
    set guifont=DroidSansMono\ 14
  endif
  set background=dark
  colorscheme gruvbox
"}

" Key Mappings {

  " Remap command
  nnoremap ; :

  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " Format paragraph
  vmap Q gq
  vmap Q gqap

  " Tabularize
  nmap <Leader>a& :Tabularize /&<CR>
  vmap <Leader>a& :Tabularize /&<CR>
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  nmap <Leader>a:: :Tabularize /:\zs<CR>
  vmap <Leader>a:: :Tabularize /:\zs<CR>
  nmap <Leader>a, :Tabularize /,<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a,, :Tabularize /,\zs<CR>
  vmap <Leader>a,, :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

  " j,k on wrapped lines
  nnoremap j gj
  nnoremap k gk

  " Easy window navigation
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

  " Quick jump to buffer list
  nnoremap <leader>b :buffers<CR>:buffer<Space>

  " Copy & Paste keybindings
  if has('mac')
      " macOS keybindings
      vnoremap <D-c> "+y
      nnoremap <D-c> "+yy
      inoremap <D-c> <Esc>"+yyi

      vnoremap <D-v> "+p
      nnoremap <D-v> "+p
      inoremap <D-v> <Esc>"+pa

      vnoremap <D-x> "+d
      nnoremap <D-x> "+dd
      inoremap <D-x> <Esc>"+ddi

      nnoremap <D-z> u
      inoremap <D-z> <Esc>ua

      nnoremap <D-y> <C-r>
      inoremap <D-y> <Esc><C-r>a
  else
      " Non-macOS keybindings (Linux, Windows, etc.)
      vnoremap <C-c> "+y
      nnoremap <C-c> "+yy
      inoremap <C-c> <Esc>"+yyi

      vnoremap <C-v> "+p
      nnoremap <C-v> "+p
      inoremap <C-v> <Esc>"+pa

      vnoremap <C-x> "+d
      nnoremap <C-x> "+dd
      inoremap <C-x> <Esc>"+ddi

      nnoremap <C-z> u
      inoremap <C-z> <Esc>ua

      nnoremap <C-y> <C-r>
      inoremap <C-y> <Esc><C-r>a
  endif

" }

" Autocmd {

  autocmd FileType python setlocal et sta sw=4 sts=4
  autocmd BufRead,BufNewFile *.rs set filetype=rust
  autocmd BufRead,BufNewFile *.nim set filetype=nim
" }
