set rnu
set nu

set nowrap
set noeb

set nobackup
set noswapfile
set noundofile

inoremap jk <ESC>

"inoremap <TAB> <C-P>
inoremap <S-TAB> <TAB>

inoremap <C-V> <ESC>"+pa

noremap <leader>z z
noremap z %
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
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent> <S-TAB> :bp<CR>
nnoremap <silent>Q :q<CR>
nnoremap <leader>q q
nmap q <C-L>
vnoremap q <ESC>
inoremap <C-H> <C-W>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set mousemodel=extend

filetype plugin indent on
set autoindent
set smartindent

set noexpandtab
set ic
set viewoptions=cursor,folds,slash,unix
nnoremap w <Plug>(smartword-w)
nnoremap b <Plug>(smartword-b)

set guicursor=n-v-c-i:block

" Compile
" Note: <S-Fx> is x+12, <C-Fx> is x+24, <S-C-Fx> is x+36, <A-Fx> is x+48
" Use insert mode to type them
au TermOpen * startinsert
au TermOpen * tnoremap <buffer> <leader><ESC> <C-\><C-N>
" nnoremap <silent><F12> :w<CR>:term bash run.sh<CR>
au FileType python nnoremap <buffer><F9> :w<CR>:term python %<CR>
au FileType python nnoremap <buffer><F33> :w<CR>:term python -i %<CR>
au FileType python nnoremap <buffer><F57> :w<CR>:term python -m pdb %<CR>
au FileType cpp nnoremap <buffer><F9> :w<CR>:term g++ % -o %< -std=c++17<CR>
" A-F9
au FileType cpp nnoremap <buffer><F57> :w<CR>:term g++ % -o %< -std=c++17 -O2<CR>
" C-F9
au FileType cpp nnoremap <buffer><F33> :w<CR>:term g++ % -o %< -std=c++17 -Wall -g -fsanitize=undefined<CR>
au FileType cpp nnoremap <buffer><F10> :term ./%<<CR>
" au FileType cpp nnoremap <buffer><F5> :term cf test %<CR>
" au FileType cpp nnoremap <buffer><F29> :term cf submit -f %<CR>
au FileType c nnoremap <buffer><F9> :w<CR>:term gcc % -o %<<CR>
au FileType c nnoremap <buffer><F10> :term ./%<<CR>
au FileType tex nnoremap <buffer><F9> :w<CR>:term xelatex %<CR>
au FileType sh nnoremap <buffer><F9> :w<CR>:term bash %<CR>
au FileType javascript nnoremap <buffer><F9> :w<CR>:term node %<CR>



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

call plug#begin('~/.local/share/nvim/site/plugged')

" Skin
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'LZDQ/umbra.nvim' " forked from 'navarasu/onedark.nvim'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'sainnhe/edge'
Plug 'morhetz/gruvbox'
Plug 'catppuccin/nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'savq/melange-nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'AlexvZyl/nordic.nvim'
Plug 'rmehri01/onenord.nvim'
Plug 'zaldih/themery.nvim' " Skin switcher

" Buffer
Plug 'akinsho/bufferline.nvim'
Plug 'elihunter173/dirbuf.nvim'
Plug 'folke/noice.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'X3eRo0/dired.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'simeji/winresizer'

" lsp, highlight, completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'lukas-reineke/cmp-under-comparator'
"Plug 'folke/lua-dev.nvim'
" Plug 'folke/neodev.nvim'
Plug 'milisims/nvim-luaref'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'zbirenbaum/copilot.lua'

" Language specific
Plug 'cuducos/yaml.nvim'
" Plug 'nvim-java/nvim-java'
Plug 'mfussenegger/nvim-jdtls'
Plug 'folke/lazydev.nvim'
Plug 'hat0uma/csvview.nvim'
Plug 'jeetsukumaran/vim-pythonsense'

" Run, Debug
Plug 'stevearc/overseer.nvim'
" Plug 'sakhnik/nvim-gdb'
" Plug 'mfussenegger/nvim-dap'

" Typefocus
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
Plug 'shortcuts/no-neck-pain.nvim'
Plug 'LZDQ/nvim-autocenter'
Plug 'nvim-focus/focus.nvim'

" Misc
Plug 'vim-scripts/restore_view.vim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'kana/vim-smartword'
Plug '3rd/image.nvim'
"Plug 'andymass/vim-matchup'
Plug 'numToStr/Comment.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gaborvecsei/cryptoprice.nvim'
Plug 'rmagatti/auto-session'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'bkad/CamelCaseMotion'
Plug 'gaborvecsei/usage-tracker.nvim'
Plug 'xiyaowong/link-visitor.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'mistricky/codesnap.nvim', { 'do': 'make' }
Plug 'ouuan/nvim-bigfile'
Plug 'NStefan002/screenkey.nvim'
Plug 'nvzone/showkeys'
Plug 'nacro90/numb.nvim'
Plug 'andweeb/presence.nvim'
Plug 'dstein64/vim-startuptime'

" Jump
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2'}
" Plug 'inside/vim-search-pulse'

" interactive python
Plug 'benlubas/molten-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" textobj
Plug 'kana/vim-textobj-user'
"Plug 'D4KU/vim-textobj-chainmember'  " m
Plug 'pianohacker/vim-textobj-indented-paragraph'  " r, g(  and g) for jump
Plug 'jceb/vim-textobj-uri'  " iu for URL
Plug 'Julian/vim-textobj-variable-segment'  " v
Plug 'kana/vim-textobj-lastpat' " search pat

" Games
Plug 'ThePrimeagen/vim-be-good'
Plug 'alec-gibson/nvim-tetris'
Plug 'seandewar/nvimesweeper'
Plug 'seandewar/killersheep.nvim'
Plug 'rktjmp/playtime.nvim'
Plug 'Eandrju/cellular-automaton.nvim'
Plug 'alanfortlink/blackjack.nvim'
Plug 'jim-fx/sudoku.nvim'

" CTF
Plug 'RaafatTurki/hex.nvim'

" git
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()


let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlPMixed'


let g:clever_f_not_overwrites_standard_mappings = 1
let g:clever_f_across_no_line = 1
let g:clever_f_timeout_ms = 1500
let g:clever_f_highlight_timeout_ms = g:clever_f_timeout_ms
nnoremap f <Plug>(clever-f-f)
nnoremap F <Plug>(clever-f-F)


set cursorline
set cursorlineopt=number
set termguicolors
au FileType * set formatoptions-=o

nnoremap > <Plug>CamelCaseMotion_w
nnoremap < <Plug>CamelCaseMotion_b


" au TextChangedI * call v:lua.vim.notify("text changed I")
" au InsertEnter * call v:lua.vim.notify("insert enter")
" au InsertCharPre * call v:lua.vim.notify("insert char pre")



" By GPT
let $FZF_DEFAULT_OPTS = '--bind ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-h:backward-char,ctrl-l:forward-char'


let g:vim_search_pulse_duration = 150
let g:vim_search_pulse_mode = 'pattern'


let g:winresizer_start_key = '<leader>r'
