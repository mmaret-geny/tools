"""""""""""""
" SHORTCUTS "
"""""""""""""
"   F3          autotags Update
" S-F3          autotags Add
"   F8          view tag list
"   F9          Open NerdTree
" M-F9          Show diff line
" S-F9          Highlight diff line
" C-left/right  switch tab
" C-up/down     switch window
" M-left/right  horizontal size
" M-up/down     vertical size

"""""""""""
" GENERAL "
"""""""""""
" disable vi-compatible mode
set nocompatible
filetype plugin on
syntax on

""""""""
" SAVE "
""""""""
" disable backup
set nobackup
" save before compilation
set autowrite
" jump to last known position when reopening a file
if has("autocmd")
        autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif
endif
" command line history
set history=50

" Check that file have not been changed
" CursorHold : after cursor move
" WinEnter or BufWinEnter
au WinEnter * checktime
au BufWinEnter * checktime

"""""""""
" INPUT "
"""""""""

" Enable mouse for 'a'll mode
set mouse=a

"""""""""""
" DISPLAY "
"""""""""""
" highlight the cursor line
set cursorline
" show the status line
set laststatus=2
" show the cursor position
set ruler
" show mode
set showmode
" display incomplete commands
set showcmd
" display line number"
set number
" set status line
set statusline=%<%f\ %h%w%m%r%3.(\ %)%{fugitive#statusline()}%=%([%{Tlist_Get_Tagname_By_Line()}]%)%3.(\ %)%-14.(%l,%c%V%)\ %P
" always display status line
set laststatus=2

" show bad white spaces
let c_space_errors = 1
let python_space_error_highlight = 1
highlight link cSpaceError SpaceError
highlight link pythonSpaceError SpaceError
highlight SpaceError ctermfg=235 cterm=reverse

if has("autocmd")
        " enable file type detection and do language-dependent indenting
        " filetype plugin indent on
        " detect indentation see http://www.freehackers.org/Indent_Finder
        if has('python')
                autocmd BufReadPost /* execute system ('python2 ~/.vim/indent_finder/indent_finder.py --vim-output "' . expand('%') . '"' )
        endif
else
        " auto-indent
        set autoindent
        " smart-indent
        set smartindent
        " C-indent
        "set cindent
        " indent-expr
        "set indentexpr ""
endif

""""""""""
" WINDOW "
""""""""""
" create window below or at right of the current one
set splitbelow
set splitright
" if multiple windows
if bufwinnr(1)
        " vertically increase/decrease window size with alt+up/alt+down
        map <M-Up> <C-W>+
        map <M-Down> <C-W>-
        imap <M-Up> <ESC><M-Up>a
        imap <M-Down> <ESC><M-Down>a
        " horizontally increase/decrease window size with alt+right/alt+left
        map <M-Right> <C-W>>
        map <M-Left> <C-W><
        imap <M-Right> <ESC><M-Right>a
        imap <M-Left> <ESC><M-Left>a
        " switch to next/previous tab with ctrl+right/ctrl+left
        map <C-Right> gt
        map <C-Left> gT
        imap <C-Right> <ESC><C-Right>a
        imap <C-Left> <ESC><C-Left>a
        " switch to next/previous window with ctrl+down/ctrl+up
        map <C-Down> <C-W>w
        map <C-Up> <C-W>W
        imap <C-Down> <ESC><C-Down>a
        imap <C-Up> <ESC><C-Up>a
endif
" open automatically quickfix window
if has("autocmd")
	autocmd QuickFixCmdPost * cw
endif

" open a file in the same directory as the current file with F2 and split with shift+F2
map <F2> :tabe <C-R>=expand("%:h") . "/"<CR>
nmap <S-F2> :split <C-R>=expand("%:h") . "/"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"Omni-completion par CTRL-X_CTRL-O
"""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Enable omnicppcompletion
set nocp
filetype plugin on
let OmniCpp_ShowAccess = 0
let OmniCpp_LocalSearchDecl=1
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
set path=.,..,/usr/local/include,/usr/include

"""""""""""
" NerdTree
"""""""""""
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <F9>   :NERDTreeToggle<CR>

"""""""""""
" GitGutter
"""""""""""
map <M-F9> :GitGutterSignsToggle <CR>
map <S-F9> :GitGutterLineHighlightsToggle <CR>

"""""""""
" Plugin"
"""""""""

" plugin taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Process_File_Always = 1
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Close_On_Select = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 0
let Tlist_Show_One_File = 1
let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
" sort by name or order ?
let Tlist_Sort_Type = "name"
"let Tlist_File_Fold_Auto_Close = 1
let Tlist_Inc_Winwidth = 0
"let Tlist_Use_Horiz_Window = 1
let Tlist_Use_Right_Window = 1
" open/close tag list window with F8
map <silent> <F8> :TlistToggle<CR>

" close preview window after a completion
if has("autocmd")
        autocmd CursorMovedI *.{[hc],cpp} if pumvisible() == 0|pclose|endif
        autocmd InsertLeave *.{[hc],cpp} if pumvisible() == 0|pclose|endif
endif

"Using vundle
"cf. https://github.com/gmarik/Vundle.vim
":PluginInstall to install them
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Show current modified line
Plugin 'airblade/vim-gitgutter'

" Communication with git
Plugin 'tpope/vim-fugitive'

" Omni completion for cpp
Plugin 'vim-scripts/OmniCppComplete'

" Filesystem exploration
Plugin 'scrooloose/nerdtree'

" List current file function
Plugin 'vim-scripts/taglist.vim'

" echofunc -> what is the current function signature
Plugin 'mbbill/echofunc'

" % match if/then/else/html ...
Plugin 'tmhedberg/matchit'

"Syntax checking
Plugin 'scrooloose/syntastic.git'
call vundle#end()
