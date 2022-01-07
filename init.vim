call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'wakatime/vim-wakatime'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinoid/vim-jsonc'
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive', {'branch': 'master'}
Plug 'airblade/vim-rooter', {'branch': 'master'}
Plug 'mhinz/vim-startify'
call plug#end()

" turn on line numbers
set number
set relativenumber

" Reduce escape timeout
set ttimeout
set ttimeoutlen=0

" map jk to exit escape remode
inoremap jk <ESC>

" type `:wrap` to turn on pretty line wrapping. `unwrap` to turn off
command Wrap  execute "set wrap linebreak"
command Unwrap execute "set nowrap nolinebreak"

" open nerdtree on startup when specifying no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if nerdtree is last open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" toggle nerdtree with ctrl+b
map <C-b> :NERDTreeToggle<CR>

" disable nerdtree ctrl bindings to prevent interfering with pane switching
let g:NERDTreeMapJumpNextSibling = ''

" show dot files in nerdtree
let NERDTreeShowHidden=1

" Disable mardown folding
let g:vim_markdown_folding_disabled = 1

" Use spaces instead of tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Add fzf mappings
nnoremap <c-p> :Files<cr>

" ============================ COC =====================

let g:coc_global_extensions = [
            \ 'coc-snippets', 
            \ 'coc-vimlsp',
            \ 'coc-spell-checker',
            \ 'coc-syntax',
            \ 'coc-git', 
            \ 'coc-python',
            \ 'coc-yaml',
            \ 'coc-rust-analyzer',
            \ 'coc-json',
            \ 'coc-vimtex',
            \ 'coc-clangd',
            \ 'coc-tsserver',
            \ 'coc-prettier'
            \]


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
set signcolumn=yes:1 " override above to always show line numbers and have coc/gitgutter compete

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" format
nmap <space>F <Plug>(coc-format)

" ======================= COC End =============================
