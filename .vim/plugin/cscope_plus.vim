" if compiled with --enable-cscope
if has("cscope")
	if exists("g:loaded_cscope_plus") || &cp
    		finish
	endif
	let g:loaded_cscope_plus   = 1.0
	
	" cat Makefile | grep '\-I\/' | tr '[:space:]' '\n' | grep '\-I/' | sort -u | tr '\n' ' '
	" build tags database with shift+F8 or alt+F8 to ignore /usr/include
	"        --c++-kinds=+p  : Adds prototypes in the database for C/C++ files.
	"        --fields=+iaS   : Adds inheritance (i), access (a) and function 
	"                          signatures (S) information.
	"        --extra=+q      : Adds context to the tag name. Note: Without this
	"                          option, the script cannot get class members.
	
	command! CtagsBuild
	    \ :!echo 'building ctags database...' ;
	    \   ctags --fields=+iaS --extra=+q --totals -R --c++-kinds=+p &&
	    \   echo 'adding system headers...' ;
	    \   find -exec gcc -M  '{}' \; 2>&- | tr '[:space:]' '\n' | grep '^/.*' | sort -u |
	    \   ctags --c-kinds=+px --c++-kinds=+px --fields=+iaS --extra=+q -aL-
	command! CtagsKernelBuild
	    \ :!echo 'building ctags database in kernel mode...' ;
	    \   ctags --fields=+iaS --extra=+q --totals -R --c++-kinds=+p
	command! CscopeBuild
	    \ :!echo 'building cscope database...' ;
	    \   cscope -bR
	command! CscopeKernelBuild
	    \ :!echo 'building cscope database in kernel mode...' ;
	    \   cscope -bkR

	if has("cscope")
	    map <S-F8> :CtagsBuild<CR><CR>:CscopeBuild<CR><CR>:cscope reset<CR><CR>:cscope add cscope.out<CR><CR>
	    map <M-F8> :CtagsKernelBuild<CR><CR>:CscopeKernelBuild<CR><CR>:cscope reset<CR><CR>:cscope add cscope.out<CR><CR>
	else
	    map <S-F8> :CtagsBuild<CR><CR>
	    map <M-F8> :CtagsKernelBuild<CR><CR>
	endif

endif
