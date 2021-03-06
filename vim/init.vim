" Modeline and Notes {
" vim: set foldmethod=marker foldmarker={,} foldlevel=0:
" }

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

    set foldenable
    set foldmethod=syntax 
    set foldlevel=1
    set foldnestmax=3
    set foldcolumn=3
  " }

  " Codecs {

    set encoding=utf-8
    set fileencodings=utf-8,ucs-bom,gbk,gb18030,utf-16,big5

    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
  "}

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
    if has("gui_macvim")
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
" }

" Plugins And Settings {

  set rtp+=~/.vim/bundle/Vundle.vim/
  call vundle#begin()
  " Plugins {
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'codota/tabnine-vim'
    Plugin 'python-mode/python-mode'
    Plugin 'godlygeek/tabular'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'preservim/nerdtree'
    Plugin 'scrooloose/syntastic'
    Plugin 'kien/rainbow_parentheses.vim'
    Plugin 'vim-scripts/matchit.zip'
    Plugin 'terryma/vim-expand-region'
    Plugin 'freiz/c.vim'
    Plugin 'a.vim'
    Plugin 'majutsushi/tagbar'
    Plugin 'Auto-Pairs'
    Plugin 'The-NERD-Commenter'
    Plugin 'quit-another-window'
    Plugin 'vim-pandoc/vim-pandoc'
    Plugin 'raichoo/haskell-vim'
    Plugin 'zah/nim.vim'
    Plugin 'thinca/vim-quickrun'
    Plugin 'tpope/vim-fugitive'
    Plugin 'mileszs/ack.vim'
    Plugin 'google/vim-searchindex'
    Plugin 'morhetz/gruvbox'
    Plugin 'muellan/am-colors'
    Plugin 'mtth/scratch.vim'
    Plugin 'iamcco/markdown-preview.nvim'
  " }
  call vundle#end()
  filetype plugin indent on

  " Bundles Setting {

    " Toggle TagBar
    map <silent> <leader>l :TagbarToggle<cr>

    " NerdTree Setting
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    map <silent> <leader>n :NERDTreeToggle<cr>

    " Rainbow Parentheses Setting
    let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0

    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces

    " Vim Powerline
    let g:Powerline_symbols='fancy'
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16'

  " }
" }

" Appearence {

  set go-=m
  set go-=T
  set cursorline
  set wrap
  set linebreak
  set nolist
  if has("mac")
    set guifont=Fira\ Mono\ for\ Powerline:h12
  elseif has("win32") || has("win64")
    set guifont=Fira\ Mono\ for\ Powerline:h12
  elseif has("unix")
    set guifont=DroidSansMono\ 12
  endif
  set background=dark
  colorscheme amdark
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

  " SHIFT-Del are Cut
  vnoremap <S-Del> "+x

  " CTRL-Insert are Copy
  vnoremap <C-Insert> "+y

  " SHIFT-Insert are Paste
  map <S-Insert>      "+gP
  cmap <S-Insert>     <C-R>+
  imap <S-Insert>     <C-R>+

" }

" Autocmd {

  autocmd FileType python setlocal et sta sw=4 sts=4
  autocmd BufRead,BufNewFile *.rs set filetype=rust
  autocmd BufRead,BufNewFile *.nim set filetype=nim
" }


