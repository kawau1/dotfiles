" VIM SETTINGS


" General
set fenc=utf-8
set showcmd
set number
set ruler
set title
set wildmenu
set cursorline
hi CursorLine cterm=NONE ctermbg=lightgrey ctermfg=NONE
set autoindent
set cindent
set visualbell
set noerrorbells
set showmatch
set laststatus=2
set showtabline=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk
nnoremap <Esc><Esc> :nohsearch<CR><ESC>
nnoremap <C-a> ggVG
nnoremap <C-c> "+y
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-z> u
nnoremap <C-y> <C-r>
vnoremap <C-c> "+y
vnoremap <C-x> "+d
vnoremap <C-v> "+p
vnoremap <C-z> u
vnoremap <C-y> <C-r>
inoremap <C-a> ggVG
inoremap <C-v> "+p
inoremap <C-z> u
inoremap <C-y> <C-r>
set backspace=indent,eol,start
set ambiwidth=double
set shellslash
set wildoptions=pum
set mouse=a
set clipboard+=unnamedplus
syntax on


" Tab
set tabstop=4
set shiftwidth=4
set autoindent
set smarttab


" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set shortmess-=S


" Status Line
" ステータスラインの色とモード名の設定
function! StatuslineMode()
    if mode() == 'n'
		hi StatusLine ctermfg=green ctermbg=white
		hi ModeNameHighlight ctermfg=green ctermbg=white cterm=bold
		return 'NORMAL'
	elseif mode() == 'i'
		hi StatusLine ctermfg=blue ctermbg=white
		hi ModeNameHighlight ctermfg=blue ctermbg=white cterm=bold
		return 'INSERT'
	elseif mode() == 'v' || mode() == 'V' || mode() == "\<C-v>"
		hi StatusLine ctermfg=red ctermbg=white
		hi ModeNameHighlight ctermfg=red ctermbg=white cterm=bold
		return 'VISUAL'
	elseif mode() == 'c'
	    hi StatusLine ctermfg=magenta ctermbg=white
		hi ModeNameHighlight ctermfg=magenta ctermbg=white cterm=bold
		return 'CMDLINE'
	else
		hi StatusLine ctermfg=yellow ctermbg=white
		hi ModeNameHighlight ctermfg=yellow ctermbg=white cterm=bold
		return 'OTHERS'
	endif
endfunction

" ステータスラインの設定
set statusline=%#ModeNameHighlight#[%{StatuslineMode()}]%#StatusLine#\ %F%m%r%h%w\ %<%=行%l、列%c\ \ %{&fenc!=''?&fenc:&enc}\ \ %{&ff}\ \ %Y\


" Tab Line
function! CustomTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" タブ番号を取得
		let tabnr = i + 1
		" タブの選択状態に応じて色を変更
		let s .= '%#TabLine#'
		" 現在のタブが選択されているかどうかを確認
		let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		" タブに含まれるバッファの状態を確認し、変更されていれば●を表示
		let buflist = tabpagebuflist(tabnr)
		let winnr = tabpagewinnr(tabnr)
		let bufnr = buflist[winnr - 1]
		let bufmodified = getbufvar(bufnr, '&mod')
		if bufmodified
	    	let s .= ' ●'
		endif
		" バッファ名の取得と表示
		let bufname = bufname(bufnr)
		if bufname != ''
			let s .= ' ' .  bufname . ' '
		else
			let s .= '[No Name] '
		endif
		" 選択されているタブの終わりを表す
		let s .= '%T'
	endfor
	" タブラインの右側に表示される空白
	let s .= '%#TabLineFill#%T'
	return s
endfunction

" カスタムのタブライン関数をセット
set tabline=%!CustomTabLine()


" Plugin
" vim-plugをインストール
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" ここにプラグインを追加
" Plug 'githubのユーザー名/リポジトリ名'
Plug 'github/copilot.vim'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install --frozen-lockfile --production',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
call plug#end()


" Plugin Settings
let g:copilot_filetypes = {'': v:true}

let g:prettier#quickfix_enabled = 0
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
