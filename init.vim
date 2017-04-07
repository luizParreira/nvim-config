syntax on

filetype off " required by vundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-rbenv'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'mxw/vim-jsx'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-markdown'
Plugin 'file:///Users/luiz/vim-swift'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'atelierbram/vim-colors_atelier-schemes'
Plugin 'nielsmadan/harlequin'
Plugin 'nightsense/seabird'
Plugin 'junegunn/goyo.vim'
Plugin 'wincent/command-t'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'w0rp/ale'
Plugin 'JuliaEditorSupport/julia-vim'

call vundle#end()

filetype indent plugin on

" Map my leader ket
let mapleader=","

" Colorscheme
colorscheme petrel
set termguicolors
set background=dark
"highlight LineNr ctermfg=grey ctermbg=black
"highlight TabLineFill ctermfg=LightGreen ctermbg=LightSkyBlue
"highlight TabLine ctermfg=black ctermbg=CornFlowerBlue
"highlight TabLineSel ctermfg=black ctermbg=RoyalBlue

" Configuring visual of linter
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

" Show partial commands in the last line of the screen
set showcmd

set t_Co=256

let hour = str2nr(system('date +%H'), 10)

" Set the dark theme between 7 PM and 6 AM

" Enable light line
set laststatus=2

" A guide column to keep the code to a maximum of 100 chars
set colorcolumn=100

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" USABILITY -------------------------------------

"add some line space for easy reading
set linespace=4

" Use case insensitive search, except when using capital letters
set ignorecase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" " While this behaviour deviates from that of Vi, it does what most users
" " coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" " line of a window
set ruler

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

" IDENTATION -----------------------------------

" Indentation settings for using 2 spaces instead of tabs.
" " Do not change 'tabstop' from its default value of 8 with this setup.
set ts=2 sw=2 sts=2
set expandtab

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" " next search
nnoremap <C-L> :nohl<CR><C-L>

" MAPPINGS --------------------------------------

" Mapping <tab> to change navigate on tabs
nmap <tab> :tabnext<CR>
" Mapping control + <tab> to go to the previous tab
nmap <S-tab> :tabprevious<CR>

" Open file under cursor in another tab
map gft <C-w>gf<CR>

" Opens XML files with xmllint
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Max of open tabs opened
set tabpagemax=100

" Blank spaces killer
" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd WinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Run to clean trailing whitespace
command FixSpaces %s/\s\+$/

" Reload the file on changes
set autoread

set clipboard=unnamed

" Copy and cut an entire line to clipboard
vmap <C-c> :w !pbcopy<CR><CR>
vmap <C-x> :!pbcopy<CR>

" Function to Increment numbers in a column.
" Extracted from: http://vim.wikia.com/wiki/Making_a_list_of_numbers
function! IncrementNumbersInColumn()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction

" Map the above function to CTRL + a
vnoremap <C-a> :call IncrementNumbersInColumn()<CR>

" Airline - status bar
" You need to install powerline fonts in order to be able to " see some icons:
" $ git clone https://github.com/powerline/fonts.git && cd fonts
" $ ./install.sh
" (using Droid Sans Mono for Powerline)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" Goodies gotten from `DestroyAllSoftware` File navigation in Vim screencast
" https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
"
" Command to print the current directory in vim `%%`
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Function to update a file name
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != old_name && new_name != ''
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" Function to update a file name using git
function! GitRenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != old_name && new_name != ''
    exec ':!git mv ' . old_name . ' ' . new_name
    redraw!
    exec ':silent q ' . old_name
    exec ':e ' . new_name
    redraw!
  endif
endfunction
map <leader>g :call GitRenameFile()<cr>
