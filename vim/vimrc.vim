" Common
syntax on
filetype plugin indent on

set number
set relativenumber

set tabstop=2
set shiftwidth=2
set expandtab

set ignorecase
set smartcase
set incsearch
set hlsearch

set scrolloff=4

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

set fileformats=unix,dos,mac

" Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'rayes0/blossom.vim'
Plug 'rose-pine/vim'
Plug 'lambdalisue/fern.vim'
Plug 'itchyny/lightline.vim'
Plug 'rbtnn/vim-ambiwidth'

call plug#end()

set termguicolors

set background=light
colorscheme rosepine_dawn

let g:lightline = { 'colorscheme': 'rosepine_dawn' }

set laststatus=2

" 改行やタブなどの不可視文字を NerdFont で見やすく表示
set list
set listchars=tab:,eol:,trail:󱁐,nbsp:,space:󱁐

" NerdFontシンボル表示用のカスタムコマンド
command! ShowHiddenChars set list
command! HideHiddenChars set nolist

" 16進ダンプ表示と切り替えのカスタムコマンド
command! HexView %!xxd
command! HexRestore %!xxd -r

" バイナリモードとテキストモードの切り替え用のカスタムコマンド
command! BinaryMode setlocal binary | e ++binary
command! TextMode setlocal nobinary | e ++nobinary

nnoremap <C-f> :Fern . -reveal=% -drawer -toggle -width=40<CR>

" Shift + j/k（カーソルを5行単位で移動）
nnoremap <S-j> 5j
nnoremap <S-k> 5k
vnoremap <S-j> 5j
vnoremap <S-k> 5k

" Ctrl + Shift + j/k（画面スクロールを5行分スクロール）
nnoremap <C-S-j> 5<C-e>
nnoremap <C-S-k> 5<C-y>
vnoremap <C-S-j> 5<C-e>
vnoremap <C-S-k> 5<C-y>

" Shift + h/l（単語単位でジャンプ）
nnoremap <S-h> b
nnoremap <S-l> w
vnoremap <S-h> b
vnoremap <S-l> w

" Ctrl + Shift + h/l（行頭と行末にジャンプ）
nnoremap <C-S-h> ^
nnoremap <C-S-l> $

" ウィンドウのナビゲーション用キーマッピング
" Normalモード
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Terminalモード用
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k


