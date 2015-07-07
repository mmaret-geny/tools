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
" always display status line
set laststatus=2

" show bad white spaces
let c_space_errors = 1
let python_space_error_highlight = 1
highlight link cSpaceError SpaceError
highlight link pythonSpaceError SpaceError
highlight SpaceError ctermfg=235 cterm=reverse


"""""""""
" Plugin"
"""""""""
"Using vundle
"cf. https://github.com/gmarik/Vundle.vim
":PluginInstall to install them
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

call vundle#end()
