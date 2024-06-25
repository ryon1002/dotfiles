let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack'
Jetpack 'tpope/vim-surround'
Jetpack 'tpope/vim-commentary'
Jetpack 'vim-scripts/ReplaceWithRegister'
Jetpack 'itchyny/lightline.vim'
Jetpack 'ap/vim-buftabline'
Jetpack 'nvim-treesitter/nvim-treesitter'
Jetpack 'bluz71/vim-moonfly-colors'
call jetpack#end()

set number
set clipboard^=unnamedplus "share clipboard
set ignorecase "ignore case in search
set smartcase "use case check for including uppercase
set ambiwidth=double "□ や○ の文字があってもカーソル位置がずれないようにする
set list "Tab、行末の半角スペース、ゼロ幅スペースを明示的に表示する
set listchars=tab:^\ ,trail:~,nbsp:% "Tab、行末の半角スペース、ゼロ幅スペースを明示的に表示する

if has('mouse') "マウスを有効にする
  set mouse=a
endif

nmap <C-_> gciw
vmap <C-_> gc

" set status line
set cmdheight=2
colorscheme moonfly

highlight Visual cterm=reverse gui=reverse

" Highlight Yank
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

