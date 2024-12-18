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

Plug 'itchyny/lightline.vim'

call plug#end()

set termguicolors

set background=light
colorscheme rosepine_dawn

let g:lightline = { 'colorscheme': 'rosepine_dawn' }

set laststatus=2

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


