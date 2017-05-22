""CTAGS
set tags=.tags;/

"" VIM SETTINGS
set shiftwidth=4
set tabstop=4
set number
set ignorecase

"" INSERT MODE - defaults at https://gist.github.com/igoodrich/5072880
au InsertEnter * hi Normal ctermbg=234 guibg=#000000
au InsertLeave * hi Normal ctermbg=232 guibg=#1b1d1e

"" (TOGGLE) WHITE SPACE HIGHLIGHTING
"" nnoremap <F12> :set list!<CR>
"" set lcs=tab:\|\ "<=traling space here
"" set lcs+=trail:·
"" set lcs+=eol:¶

"" (ALWAYS ON - RED) WHITE SPACE HIGHLIGHTING
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"" Show name of function you're currenly in!
noremap <F10> :call ShowFuncName() <CR>
fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

"" Show all possible ctag matches
map <F12> :tjump <C-r><C-w><CR>zt<C-G>
