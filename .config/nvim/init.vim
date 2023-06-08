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
Jetpack 'itchyny/lightline.vim'
Jetpack 'ap/vim-buftabline'
call jetpack#end()

set number "行数表示
set ambiwidth=double "□ や○ の文字があってもカーソル位置がずれないようにする
set clipboard^=unnamedplus "クリップボードを共有
set ignorecase "検索の時に大文字小文字を区別しない
set smartcase "ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set incsearch "インクリメンタルサーチ
set list "Tab、行末の半角スペース、ゼロ幅スペースを明示的に表示する
set listchars=tab:^\ ,trail:~,nbsp:% "Tab、行末の半角スペース、ゼロ幅スペースを明示的に表示する

if has('mouse') "マウスを有効にする
  set mouse=a
endif

" ステータスライン設定
set cmdheight=2

