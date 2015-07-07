"""""""""""""
" SHORTCUTS "
"""""""""""""
"   F8          view tag list


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

" List current file function
Plugin 'vim-scripts/taglist.vim'
call vundle#end()
