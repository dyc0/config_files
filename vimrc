set nocompatible

nnoremap <SPACE> <Nop>
let mapleader = " "

" Search shortcuts
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :Rg<CR>

" Tabs and buffer shortcuts
nnoremap <silent> <Leader>td :tabclose<CR>
nnoremap <silent> <Leader>tn :tabnew<CR>
nnoremap <silent> <Leader>t1 1gt
nnoremap <silent> <Leader>t2 2gt
nnoremap <silent> <Leader>t3 3gt
nnoremap <silent> <Leader>t4 4gt
nnoremap <silent> <Leader>t5 5gt
nnoremap <silent> <Leader>t6 6gt
nnoremap <silent> <Leader>t7 7gt
nnoremap <silent> <Leader>t8 8gt
nnoremap <silent> <Leader>t9 9gt
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bb :buffers<CR>
nnoremap <silent> <Leader>bn :bn<CR>

nnoremap <silent> <Leader>wh <C-w>h
nnoremap <silent> <Leader>wj <C-w>j
nnoremap <silent> <Leader>wk <C-w>k
nnoremap <silent> <Leader>wl <C-w>l

" Basic settings
set relativenumber
set shiftwidth=4

" PLUGINS

" Plugin installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'mhinz/vim-startify'

" Tabline
 Plug 'itchyny/lightline.vim'

" Nerdtree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'nordtheme/vim'
Plug 'sainnhe/everforest' 

call plug#end()

" SETTING THEME
colorscheme everforest

" NERDtree
nnoremap <silent> <Leader>ft :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
" Close the tab if NERDTree is the only window remaining in it.
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Ohters cant replace NERDTree in buffer
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Same NERDTree on every tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"Setting fzf
let g:fzf_action = {'enter': 'tab split'}


" SETTING COC
set updatetime=300
set signcolumn=yes

set nowritebackup
set nobackup

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap autocomplete confirm to tab
inoremap <silent> <Tab> <Nop>
inoremap <silent> <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

" Jumping around
nmap <silent> <Leader>cd <Plug>(coc-definition)
nmap <silent> <Leader>cy <Plug>(coc-type-definition)
nmap <silent> <Leader>ci <Plug>(coc-implementation)

" Using K to show documentation in preview window
nnoremap <silent> <Leader>ck :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlighting
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <Leader>cr <Plug>(coc-rename)
