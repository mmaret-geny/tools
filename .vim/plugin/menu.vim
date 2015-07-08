" Enjoy the right click button!
" Custom right click menu to call cscope functions
"

if exists("loaded_menu")
  finish
endif
let loaded_menu = 1
set mousemodel=popup


function! PopulateMenu()
	exe "amenu PopUp.-Sep-									:"
	exe "amenu PopUp.Help\\ !<Tab><F1>							:call Help()<CR>"
	exe "amenu PopUp.-Sep1-									:"
	exe "amenu PopUp.Find\\ File<Tab><F4>							:cscope find f <C-R>=expand('<cfile>')<CR><CR>"
	exe "amenu PopUp.Find\\ Symbol<Tab><F5>							:cscope find s <C-R>=expand('<cword>')<CR><CR>"
	exe "amenu PopUp.Find\\ Definition<Tab><F6>						:cscope find g <C-R>=expand('<cword>')<CR><CR>"
	exe "amenu PopUp.Find\\ Call<Tab><F7>							:cscope find c <C-R>=expand('<cword>')<CR><CR>"
	exe "amenu PopUp.Find\\ Text<Tab>							:cscope find t <C-R>=expand('<cword>')<CR><CR>"
	exe "amenu PopUp.Find\\ Egrep<Tab>							:cscope find e <C-R>=expand('<cword>')<CR><CR>"
	exe "amenu PopUp.Go\\ Back<Tab><Ctl-t> 							<C-t>"
	exe "amenu PopUp.-Sep2-									:"
	exe "amenu PopUp.Create\\ local\\ code\\ reference<Tab><M-F8>				:CtagsKernelBuild<CR><CR>:CscopeKernelBuild<CR><CR>:cscope reset<CR><CR>:cscope add cscope.out<CR><CR>"
	exe "amenu PopUp.Create\\ local\\ code\\ reference\\ with\\ system\\ headers<Tab><S-F8>	:CtagsBuild<CR><CR>:CscopeBuild<CR><CR>:cscope reset<CR><CR>:cscope add cscope.out<CR><CR>"
	exe "amenu PopUp.Create\\ global\\ code\\ reference<Tab><F3>				:call AutotagsUpdate()<CR>"
	exe "amenu PopUp.Create\\ global\\ code\\ reference\\ for\\ path<Tab><Shift-F3>		:call AutotagsAdd()<CR>"
	exe "amenu PopUp.-Sep3-									:"
	exe "amenu PopUp.Toggle\\ show\\ function<Tab><F8>					:TlistToggle<CR>"
endfunc


if has("vim_starting")
	augroup LoadBufferPopup
	au! VimEnter * call PopulateMenu()
	au  VimEnter * au! LoadBufferPopup
	augroup END
else
	call PopulateMenu()
endif
