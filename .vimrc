                " " " " " " " " " " " " " "
                " Author: zezhyrule       "
                " Last Edited: 2013-05-09 "
                "                         "
     " ~ ~ ~    " " " " " " " " " " " " " "    ~ ~ ~ "
                " List of plugins I use:  "
                "                         "
                " a.vim                   "
                " abolish.vim             "
                " ag.vim
                " ctrlp.vim               "
                " fugitive.vim
                " NERD_commenter.vim      "
                " NERD_tree               "
                " snipMate.vim            "
                " surround.vim            "
                " syntastic               "
                " tagbar.vim              "
                "                         "
                " " " " " " " " " " " " " "



" Use Vim settings, rather than Vi settings (much better!).
set nocompatible


"                  ====================
"                ~ = General Settings = ~
"                  ====================

set backspace=indent,eol,start " allow backspacing over everything in insert mode
if has("vms")
    set nobackup               " do not keep a backup file, use versions instead
else
    set backup                 " keep a backup file
endif
set backupdir=~/.vim/backup    " send backup files to .vim/backup
set noswapfile                 " disable saving swap files
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase                 " ignore case in searches-
set smartcase                  " unless you enter a capital letter
"set visualbell                 " no sounds
"set autoread                   " reload files changed outside of vim
"set undofile                   " saves undos in a file so you can undo after reopen
set cursorline                 " highlights the line the cursor is on
set rnu                        " relative number lines as default
set scrolloff=5                " start scrolling when 5 lines from margins
set t_Co=256
colorscheme jellybeans-Xresources
execute pathogen#infect()
let mapleader=","              " change leader to comma

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


"================= Autocommand Stuff ====================

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " highlight cursorline in active window
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline

  " in insert mode, auto turn on absolute numbered lines
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

"========================================================



"                  ====================
"                ~ =    Whitespace    = ~
"                  ====================


set tabstop=4                  " tab character is 4 columns
set softtabstop=4              " tab key indents 4
set shiftwidth=4               " ==, <<, and >> indent 4 columns
set expandtab                  " tab characters turn into spaces


"========== TextMate-Style Visible Whitespace ===========

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use cool symbols for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"========================================================


"===== Change Whitespace Settings Based on Filetype =====

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

"========================================================


"=============== Strip Trailing Whitespace ==============

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"========================================================



"                  ====================
"                ~ =   Key Mappings   = ~
"                  ====================


"======================= General ========================

"open bracket will add close bracket and put cursor in between
" inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
" inoremap \" \""<Esc>i
" inoremap < <><Esc>i

" Don't use Ex mode, use Q for quick macro
map Q @q

" Y to yank to end of line. use yy for yanking whole line
map Y y$

" insert new line without entering insert mode.
map <CR> o<Esc>

" accidentally entering capital q won't hurt anyone
cnoreabbrev Q q
" but ctrl-e is easier anyway
map <C-E> ZQ

" press space to center screen on cursor
nmap <space> zz
" searching will keep cursor on middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" j and k will move on visual lines, not actual lines
map j gj
map k gk
" H to bol, L to eol
noremap H ^
noremap L g_

" maps jk to escape key in insert mode
"imap jk <Esc>

" ,-a for Ag.vim
nnoremap <Leader>a :Ag<Space>

"========================================================


"================= Windows and Buffers ==================

" New vertical split with ,-wv
nnoremap <Leader>wv <C-w>v<C-w>l
" Close windows with ,-wc
nnoremap <Leader>wc <C-w>c

" move between windows with arrow keys (ctrl-w+hjkl is probably better though)
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l

" move between buffers with ,-left/right
nnoremap <silent> <Leader><Left> :bp<CR>
nnoremap <silent> <Leader><Right> :bn<CR>

" ,-y to switch between two most recent buffers
nmap <Leader>y :b#<CR>

" ,-ev to edit vimrc in vertical split
nnoremap <Leader>ev <C-w><C-v><C-w><C-l>:e $MYVIMRC<CR>

" ,-sv to source the vimrc
nnoremap <Leader>sv :source<Space>$MYVIMRC<CR>

"========================================================


"==================== Function Keys =====================

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

" delete whitespace at eols with F6
nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>

" toggle nerdtree with f7
map <F7> :NERDTreeToggle<CR>

" toggle tagbar with f8
map <F8> :TagbarToggle<CR>

" toggle hardmode with f9
noremap <F9> <Esc>:call ToggleHardMode()<CR>

"========================================================


"====================== C Stuff =========================

" Header comment template mapped to ,h
nnoremap <Leader>h  i/*<CR><Space><Esc>50i=<Esc>o<CR><Tab><Tab>Filename:<Space><CR><CR>Description:<Space><CR><CR>Created:<Space><CR>Author:<Space>Charles<Space>Davis<CR><CR><Esc>a<Space><Esc>50a=<Esc>o<Esc>a/<CR><CR><Esc>10kA

" Function comment template mapped to ,f
nnoremap <Leader>f i/*<CR>Funtion:<Space><CR>-=-=-=-=-=-=-=-=-<CR><CR><CR>-inputs-<CR><BS><BS><CR>returns:<Space><CR>/<Esc>7kA

" Open definition in split with ,/
nnoremap <Leader>/ :vsp<CR> :exec("tag ".expand("<cword>"))<CR>

"========================================================


"====================== Fugitive ========================

" Edit Git Files
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gh :Gsplit<CR>
nnoremap <Leader>gv :Gvsplit<CR>

" Git Diff
nnoremap <Leader>gd :Gdiff<CR>

" Git Status
nnoremap <Leader>gs :Gstatus<CR>

" Commit
nnoremap <Leader>gc :Gcommit<CR>

" Git Blame
nnoremap <Leader>gb :Gblame<CR>

" Git Move and Remove
nnoremap <Leader>gm :Gmove<CR>
nnoremap <Leader>gr :Gremove<CR>

"========================================================


"======================= Saving =========================

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
" Ctrl-s to save in normal mode
nnoremap <silent> <C-S> :<C-u>Update<CR>
" Ctrl-s to save while in insert mode
inoremap <c-s> <c-o>:Update<CR>

" w!! to sudo write
cmap w!! w !sudo tee % >/dev/null<CR>

"========================================================


"==================== X11 Clipboard =====================
"
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
" map <C-V>       "+gP
map <S-Insert>      "+gP

cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+

"========================================================


"=================== Smooth Scrollin' ===================

noremap <silent> <C-U> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <C-D> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <C-B> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <C-F> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"========================================================


"========================= Misc =========================

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" function to toggle rnu and nu
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
" ,-n to toggle
nnoremap <Leader>n :call NumberToggle()<CR>

" hide search hl with ctrl+l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

"========================================================
