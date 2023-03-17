set nocompatible

nnoremap <SPACE> <Nop>
let mapleader = " "

" Search shortcuts
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :Rg<CR>

" Tabs and buffer shortcuts
nnoremap <silent> <Leader>tq :tabclose<CR>
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

" Basic settings
set relativenumber
set shiftwidth=4

" Themes

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

" Nerdtree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'vim-scripts/a.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" NERDtree
nnoremap <silent> <Leader>ft :NERDTree<CR>

"Setting fzf
let g:fzf_action = {'enter': 'tab split'}

" Setting tabline
set tabline=%!MyTabLine()  " custom tab pages line
set showtabline=2
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction


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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Using K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlighting
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <Leader>sr <Plug>(coc-rename)
