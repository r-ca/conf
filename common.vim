" Config
set smartindent
set expandtab

set cursorline
set number

set shiftwidth=4
set softtabstop=4
set tabstop=4
set nowrap

" Common keymaps
" Back to normal mode
inoremap <S-Space> :stopinsert<CR>
tnoremap <S-Space> <C-\><C-n>
vnoremap <S-Space> <Esc>

" Cursor navigation (Insert)
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

