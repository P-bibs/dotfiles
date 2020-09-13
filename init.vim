call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wakatime/vim-wakatime'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
call plug#end()

" turn on line numbers
set number

" type `:wrap` to turn on pretty line wrapping. `unwrap` to turn off
command Wrap  execute "set wrap linebreak"
command Unwrap execute "set nowrap nolinebreak"

" open nerdtree on startup when specifying no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if nerdtree is last open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" disable nerdtree ctrl bindings to prevent interfering with pane switching
let g:NERDTreeMapJumpNextSibling = ''

" show dot files in nerdtree
let NERDTreeShowHidden=1

" Use ripgrep for CtrlP fuzzy file finding
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

