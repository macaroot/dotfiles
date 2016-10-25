"" plug.vim, plugin manager
call plug#begin('~/.vim/plugged')
                                        " :PlugInstall - installs all the uncommented Plugs
"Plug 'easymotion/vim-easymotion'
"Plug 'scrooloose/nerdtree'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'tpope/vim-fugitive'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'tmux-plugins/vim-tmux-focus-events'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-commentary'
"Plug 'vimwiki/vimwiki'
"Plug 'SirVer/ultisnips'                 " snippets engine
"Plug 'honza/vim-snippets'               " snippet library
"Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/syntastic'             " error detection

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%*

let g:statline_syntastic = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_include_dirs = ['/usr/include/SDL2', '/usr/include/GL/']


" trigger configuration for ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" set terminal
"set term=rxvt-unicode
"if &term =~ '256color'
"    " Disable Background Color Erase (BCE) so color schemes render properly
"    " inside 256-color tmux and GNU screen
"    set t_ut=
"endif

set nocompatible                        " choose no compatibility with legacy vi
filetype plugin on                      " load filetype plugins
filetype indent on                      " load filetype indentation
syntax on                               " enable syntax highlighting
set encoding=utf8                       " utf8 as standard encoding and en_US standard language
set autoread                            " autoread when file changed from outside
set showcmd                             " display incomplete commands
set nostartofline                       " stops certain things from going to SOL
set laststatus=2                        " always display statusline and format it???
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set confirm                             " ask to save if something is wrong
set mouse=a                             " mouse can be used in all modes
set relativenumber                      " start with relatives
set so=5                                " j and k move 5 lines
set ruler                               " always show current position
set magic                               " turns on magic for Regular Expression
" set nobackup                            "|
" set nowb                                " nobackup and annoying swap files
" set noswapfile                          "|
" set rtp+=~/.fzf                         " connect to fuzzy file search, ctrl+t to use. I'm using vim.plug to manage it, it was recommended
set clipboard=unnamedplus               " this should allow pasting from x applications and others


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Relative/Absolute line numbers
                                        " function to switch between modes
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
                                        " calling switch function with C-n
nnoremap <C-n> :call NumberToggle()<cr>
                                        " forcing absolute on out-of-focus windows
:au Focuslost * :set number
:au FocusGained * :set relativenumber
                                        " forcing absolute on insert-mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Whitespace
set tabstop=4 shiftwidth=4              " a tab is four spaces
"set expandtab                           " pressing tabs inserts spaces, ctrl-V<Tab> to insert normal tab
set backspace=indent,eol,start          " backspace through everything in insert mode
set whichwrap+=<,>,h,l                  " things that should wrap, wrap
set smarttab                            " uses spaces for alignment, makes the code look same in different machines(?)
set lbr tw=500                          " uses linebreak, at 500 characters
set ai si wrap                          " autoindent, smartindent, wrap lines, don't know if will cause problems
set list
set listchars+=eol:\ ,tab:\|\ ,trail:·     " show eol trailing space whitespaces as characters
autocmd ColorScheme * highlight SpecialKey ctermbg=15 ctermfg=180



"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Visuals
" set number                            " show line numnbers
set cursorline                          " underline current line
set wildmenu                            " visual autocomplete for command menu
set showmatch                           " highlight matching brackets
set mat=3                               " bracket match blinks 3/10s of a sec
set cmdheight=3                         " cmd window set to three
color solarized                         " colorscheme solarized
set background=light                      " though autodetect should perhaps get this already
set lazyredraw                          " don't redraw while executing macros, better performance

" specifies column markers and color for 80 and 120 onwards
"let &colorcolumn="80,".join(range(120,999),",")
let &colorcolumn=join(range(80,999),",")
highlight ColorColumn ctermbg=7

" specifies buffer behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" return to last edit position when opening files
" autocmd BufReadPost *
  "\ if line("'\"") > 0 && line("'\""_) <= line("$") |
  "\  exe "normal! g'\"" |
  "\ endif
" remember info about open buffers on close
set viminfo^=%

" delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.html :call DeleteTrailingWS()

" \ss to toggle spellchecking
map <leader>ss :setlocal spell!<CR>
" some shotcuts for spellchecking I guess
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" \m to remove Windows ^M's when encoding messes up
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
" or just do :%s///g
"  is made with ctrl+v + ctrl+m


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Folding
" :mkview to save your folds, :loadview when you next have the file open to reload
set foldenable                          " enable folding, || za opens/closes folds
set foldlevelstart=10                   " open most folds by default
set foldnestmax=10                      " 10 nested folds max
set foldmethod=indent                   " fold based on indent level


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Searching
set hlsearch                            " highlight matches
set incsearch                           " incremental search
set ignorecase                          " searches are case sensitive...
set smartcase                           " ...unless you put in capitals 
" press gv to search visually selected with vimgrep
vnoremap <silent> gv :call VisualSelection('gv')<CR>
" press \g to open vimgrep and put cursor in the right position
map <leader>g :vimgrep // **/*. <left><left><left><left><left><left><left>
" \<space> vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>
" \r to search and replace selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
" " Do :help cope to find out what cope is
" " When you search with vimgrep, display your results in cope by doing:
"<leader>cc
" " to go to the next search result do:
" <leader>n
" " to go to the previous:
" <leader>p
map <leader>cc :botright cope<CR>
map <leader>co ggVGy:tabnew<CR>:set syntax=qf<CR>pgg
map <leader>b :cn<CR>
map <leader>p :cp<CR>
" " Fuzzy finder command rebound, couldn't get it to work
" nnoremap <silent> <leader>f :call fzf#run<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Autocompletion
set path+=**                            " searches stuff from current folder and below

"""""""""""""""""""""""""""""""""""""""""""""""""""""">
"" Remaps
                                        " * and # find next and previous
                                        " occurrences of current visual
                                        " selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
                                        " comma as leader with(?) \
let mapleader = ","
                                        " easier window navigation, || splits done with :split and :vsplit
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
                                        " more natural split opening
set splitbelow
set splitright
                                        " close current/all buffers
map <leader>bd :Bclose<CR>
map <leader>ba :Bclose<CR>
                                        " manage tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<CR>
map <leader>tl :tabn<CR>
map <leader>th :tabp<CR>
                                        " opens new tab with current buffers tab
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
                                        " switch cwd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
                                        " move vertically by visual lines
nnoremap j gj
nnoremap k gk
                                        " highlight last inserted text
" nnoremap gV `[v`]
                                        " Y acts like D and C (i.e. yank until EOL), rather than yy, OR just use g_
" map Y y$
                                        " C-L (redraw screen) also turns off search until next search
nnoremap <leader>l :nohl<CR><C-L>
                                        " stop using arrows
"inoremap <Up> <NOP>
"inoremap <Down> <NOP>
"inoremap <Left> <NOP>
"inoremap <Right> <NOP>
                                        " also in normal, cool line moving tricks
noremap <Up> ddkP
noremap <Down> ddp
noremap <Left> bhd2iWBhP
noremap <Right> bhd2iWWhp
                                        " STOP USING hjkl YOU PUSSY
" noremap <k> <NOP>
" noremap <j> <NOP>
" noremap <h> <NOP>
" noremap <l> <NOP>

" WINDOWSWAPPING!!!!!
                                        " use leader mw to mark window to be swapped, then go to where you want to swap and do leader pw
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf 
  endfunction
  
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" pastemode switching to prevent funky indentation. F2 in normal mode will invert 'paste' option and then show it's value, in insert mode it toggles in and out of pastemode, last thing shows mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" to create language specific settings for certain filetypes/file extensions
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    \:call <SID>StripTrailingWhitespaces()
  autocmd FileType java setlocal noexpandtab
  autocmd FileType java setlocal list
  autocmd FileType java setlocal listchars=tab:+\ ,eol:-
  autocmd FileType java setlocal formatprg=par\ -w80\ -T4
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal list
  autocmd FileType php setlocal listchars=tab:+\ ,eol:-
  autocmd FileType php setlocal formatprg=par\ -w80\ -T4
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

""" don't close window when deleting a buffer
" command! Bclose call <SID>BufcloseCloseIt()
  " let l:currentBufNum = bufnr("%")
  " let l:alternateBufNum = bufnr("#")
" 
  " if buflisted(l:alternateBufNum)
  "   buffer #
  " else
  "   bnext
  " endif
" 
  " if bufnr("%") == l:currentBufNum
  "   new
  " endif
" 
  " if buflisted(l:currentBufNum)
  "   execute("bdelete! ".l:currentBufNum)
  " endif
" endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" crazy shit
" Press capital Q to make vim take a line you've written in a file, have it execute it on the shell, return result to that line
" :noremap Q !!$SHELL<CR>


" netrw
" :b buffers
" :mksession saves session, vim -S opens it
" :cw shows log of errors in file
" typing just fg in terminal brings back stopped/suspended vim process, if you accidentally C-z'd. bg throws process in background
" C-N pops up a small window containing keywords from your files
" C-C C-F pops up a list of filenames
" C-X C-V pops vim keywords when in command line
" C-X s suggests spelling alternatives
" C-x C-L suggests how to finish complete lines
" :help ins-completion for more info
