"source /etc/vimrc "念のため初期設定の読み込み

set ambiwidth=double "□や○の文字があってもカーソル位置がずれないようにする
set backspace=indent,eol,start "バックスペースでインデントや改行を削除できるようにする
if has('mouse') "マウスを有効にする
  set mouse=a
endif
set number "行数表示
set title "タイトル表示
set clipboard+=unnamed "クリップボードを共有
set clipboard+=unnamedplus "クリップボードを共有
"set clipboard+=autoselected "クリップボードを共有
set ignorecase "検索の時に大文字小文字を区別しない
set smartcase "ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set incsearch "インクリメンタルサーチ
set hlsearch "検索文字の強調表示
set showcmd "画面最後の行をできる限り表示する
set display=lastline "画面最後の行をできる限り表示する
set list "Tab、行末の半角スペースを明示的に表示する
set listchars=tab:^\ ,trail:~ "Tab、行末の半角スペースを明示的に表示する
set t_Co=256
colorscheme ron

" ステータスライン設定
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\
set cmdheight=2
set laststatus=2
highlight statusline   term=NONE cterm=NONE ctermbg=yellow ctermfg=black

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guibg=darkblue gui=none ctermbg=cyan cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


