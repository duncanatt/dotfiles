syntax on

" Use onedark color scheme.
colorscheme onedark

" General configuration.
set number

" Vim-plug configuration.
call plug#begin('~/.vim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Reconfigure default airline theme to onedark.
let g:airline_theme='onedark'

" Keybindings for nerdtree.
nnoremap <C-t> :NERDTreeToggle<CR>
