let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tikhomirov/vim-glsl'
Plug 'github/copilot.vim'
Plug 'whonore/Coqtail'
call plug#end()

" set leader to space
let mapleader =" "

set mouse=

" source vimrc on save
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"

" use backspace to switch to last buffer
nnoremap <BS> <c-^>

" turn on line numbers
set number
set relativenumber

" Reduce escape timeout
set ttimeout
set ttimeoutlen=0

" map jk to exit escape remode
inoremap jk <ESC>

" use escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" type `:wrap` to turn on pretty line wrapping. `unwrap` to turn off
command Wrap  execute "set wrap linebreak"
command Unwrap execute "set nowrap nolinebreak"

" alias :W to :w to fix fat fingers
command W execute "w"

" use leader as shortcut for splits
nnoremap <leader>- :split<cr>
nnoremap <leader>\| :vsplit<cr>

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
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab expandtab

" Add fzf mappings
nnoremap <c-p> :GFiles<cr>
nnoremap <A-p> :Commands<cr>

" ========================== AIRLINE ==================
let g:airline_powerline_fonts = 1

" fix to allow powerline symbols to work
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#tabline#enabled = 1
" ========================== AIRLINE end ==============


" ======================== Coq Start ================
let g:coqtail_noimap = 1
inoremap <c-J> <Plug>CoqNext
" ================= Coq End =========================


" ============================ COC =====================

let g:coc_global_extensions = [
            \ 'coc-snippets', 
            \ 'coc-vimlsp',
            \ 'coc-spell-checker',
            \ 'coc-syntax',
            \ 'coc-git', 
            \ 'coc-yaml',
            \ 'coc-rust-analyzer',
            \ 'coc-json',
            \ 'coc-vimtex',
            \ 'coc-clangd',
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-tailwindcss',
            \ 'coc-tsserver',
            \ 'coc-go'
            \]


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

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

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

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

" allow checking type of value at cursor in OCaml
" https://discuss.ocaml.org/t/type-at-point-ocaml-lsp-merlin-in-vim-neovim/6832
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call CocShowDocumentation()<CR>
function! CocShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting all code
nmap <space>F <Plug>(coc-format)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" enable switch between source and header
nmap <A-o> :CocCommand clangd.switchSourceHeader<CR>


" ======================= COC End =============================

