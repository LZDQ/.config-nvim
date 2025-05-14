inoremap jk <ESC>

set rnu
set nu

set nowrap
set noeb
set nobackup
set noswapfile
set noundofile
set noexpandtab

set ic

inoremap <S-TAB> <TAB>

inoremap <C-V> <ESC>"+pa
nnoremap ;y "+y

noremap <leader>z z
map z %
set foldenable
set foldmethod=manual
onoremap v V%
nnoremap Z za
vnoremap Z zf
nnoremap + zR
nnoremap - zM
noremap <DEL> zD

nnoremap <C-C> gg"+yG
vnoremap <C-C> "+y
noremap <space> $
noremap <BS> zz
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>
nnoremap <HOME> <C-B>
nnoremap <END> <C-F>
nnoremap <UP> <C-Y>
nnoremap <DOWN> <C-E>
nnoremap <LEFT> zH
nnoremap <RIGHT> zL
nnoremap <TAB> <CMD>bn<CR>
nnoremap <S-TAB> <CMD>bp<CR>
nnoremap Q <CMD>q<CR>
nnoremap <leader>q q
nmap q <C-L><CMD>lua require('notify').dismiss()<CR>
vnoremap q <ESC>
" Ctrl-Backspace to delete a word
inoremap <C-H> <C-W>
inoremap <C-BS> <C-W>
nnoremap <C-W><C-D> <CMD>bd<CR>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set mousemodel=extend

filetype plugin indent on
set autoindent
set smartindent

set viewoptions=cursor,folds,slash,unix
set guicursor=n-v-c-i:block
set cursorline
set cursorlineopt=number
set termguicolors

au FileType * set formatoptions-=o

" Compile
" Note: <S-Fx> is x+12, <C-Fx> is x+24, <S-C-Fx> is x+36, <A-Fx> is x+48
" Use insert mode to type them
au TermOpen * startinsert
au TermOpen * tnoremap <buffer> <leader><ESC> <C-\><C-N>
au FileType python nnoremap <buffer><F9> :w<CR>:term python %<CR>
au FileType python nnoremap <buffer><F33> :w<CR>:term python -i %<CR>
au FileType python nnoremap <buffer><F57> :w<CR>:term python -m pdb %<CR>

au FileType cpp nnoremap <buffer><F9> :w<CR>:term g++ % -o %< -std=c++17<CR>
" A-F9
au FileType cpp nnoremap <buffer><F57> :w<CR>:term g++ % -o %< -std=c++17 -O2<CR>
" C-F9
au FileType cpp nnoremap <buffer><F33> :w<CR>:term g++ % -o %< -std=c++17 -Wall -g -fsanitize=undefined<CR>
au FileType cpp nnoremap <buffer><F10> :term ./%<<CR>

au FileType c nnoremap <buffer><F9> :w<CR>:term gcc % -o %<<CR>
au FileType c nnoremap <buffer><F10> :term ./%<<CR>

au FileType tex nnoremap <buffer><F9> :w<CR>:term xelatex %<CR>
silent! execute "set <M-a>=\<Esc>a"
au FileType tex inoremap <buffer><M-a> \bigskip \textbf{Answer}:<CR>

au FileType sh nnoremap <buffer><F9> :w<CR>:term bash %<CR>

au FileType javascript nnoremap <buffer><F9> :w<CR>:term node %<CR>

" test, and submit on success
au FileType cpp nnoremap <buffer><F5> :term pyforces test -f % && pyforces submit<CR>
" test
au FileType cpp nnoremap <buffer><F6> :term pyforces test<CR>
" submit
au FileType cpp nnoremap <buffer><F7> :w<CR>:term pyforces submit -f %<CR>

" python support, with program_type_id=70 (PyPy 3.10)
au FileType python nnoremap <buffer><F5> :term pyforces test -f % && pyforces submit --file=% --program-type-id=70<CR>
au FileType python nnoremap <buffer><F6> :term pyforces test -f %<CR>
au FileType python nnoremap <buffer><F7> :w<CR>:term pyforces submit -f % --program-type-id=70<CR>

function WriteFor(str)
	let a=""
	let b=""
	let c=""
	if strlen(a:str)==3
		let a=a:str[0]
		let b=a:str[1]
		let c=a:str[2]
	else
		" a=b; a<=c; a++
		let w=1
		let s1=0
		let s2=0
		for i in range(0,strlen(a:str)-1)
			if a:str[i]==',' && s1==0 && s2==0
				let w=w+1
			else
				if w==1
					let a = a . a:str[i]
					" echo a:str[i] . ' ' . a
				elseif w==2
					let b = b . a:str[i]
				else
					let c = c . a:str[i]
				endif
				if a:str[i]=='('
					let s1=s1+1
				elseif a:str[i]==')'
					let s1=s1-1
				elseif a:str[i]=='['
					let s2=s2+1
				elseif a:str[i]==']'
					let s2=s2-1
				endif
			endif
		endfor
	endif
	if b=="-"
		let outputstr = "for(int " . a . "=" . "0; ". a . "<"
	else
		let outputstr = "for(int " . a . "=" . b . "; " . a  . "<"
	endif
	if b!="0"
		let outputstr = outputstr . "="
	endif
	let outputstr = outputstr . c . "; " . a . "++)"
	execute "normal! cc" . outputstr
endfunction

function WriteEdge(str)
	"iu
	let outputstr = "for(int " . a:str[0] . "=h[" . a:str[1] . "]; " . a:str[0] . "; " . a:str[0] . "=nx[" . a:str[0] . "])"
	execute "normal! cc" . outputstr
endfunction

function WriteScanf(str)
	"n,m
	let s1 = "scanf(\"%d"
	let s2 = " &"
	for i in range(0, strlen(a:str)-1)
		let s2 = s2 . a:str[i]
		if a:str[i]==','
			let s1 = s1 . "%d"
			let s2 = s2 . " &"
		endif
	endfor
	let ans = s1 . "\"," . s2 . ");"
	execute "normal! cc" . ans
endfunction

autocmd FileType cpp inoremap <C-F> <esc>:call WriteFor("")<left><left>
autocmd FileType cpp inoremap <C-U> <esc>:call WriteEdge("")<left><left>
autocmd FileType cpp inoremap <C-C> <esc>:call WriteScanf("")<left><left>
autocmd FileType cpp nnoremap <F8> :r ~/OI/tem/

nnoremap <F1> <CMD>Lazy<CR>


lua require("config.lazy")
