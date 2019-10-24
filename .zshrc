## 補完機能の強化
autoload -U compinit
compinit -u

setopt nobeep # ビープを鳴らさない
setopt auto_cd # ディレクトリ名だけでcd
setopt auto_resume ## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
unsetopt promptcr ## 出力の文字列末尾に改行コードが無い場合でも表示
setopt correct ## スペルチェック
setopt ignoreeof ## ^D not log out
setopt NO_flow_control ## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt print_eight_bit ## 出力時8ビットを通す(日本語表示用？)

# zmvを使う
autoload zmv
alias zmv='noglob zmv'

# cdr設定
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

setopt auto_pushd # ディレクトリ履歴
setopt pushd_ignore_dups # 重複履歴を登録しない
setopt extended_glob # 拡張グロブを使う
setopt numeric_glob_sort # ファイル名の展開で辞書順ではなく数値的にソート
setopt equals # =command を command のパス名に展開する
setopt brace_ccl # {a-c} を a b c に展開する機能を使えるようにする
setopt mark_dirs # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する

## 履歴検索の設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
HISTFILE=$HOME/.zsh-history # 履歴の保存先
HISTSIZE=100000 # メモリに展開する履歴の数
SAVEHIST=100000 # 保存する履歴の数
setopt hist_ignore_all_dups # 履歴を重複して保時しないs
setopt hist_ignore_dups # 同じヒストリは登録しない
setopt hist_no_store # history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集
setopt share_history # ヒストリを共有
setopt hist_reduce_blanks #余計な空白を削除
setopt complete_in_word # 単語途中からの補完を許す
setopt always_to_end # 補完時に単語の後ろまでいく

## キーバインドの設定
bindkey -e
bindkey "^o" menu-complete #Ctrl+oでメニュー選択
bindkey "^q" push-line #Ctrl+qでコマンドラインスタック
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey '^[[1;5D' backward-word #ctrlのワード移動
bindkey '^[[1;5C' forward-word #ctrlのワード移動
#bindkey "^r" history-incremental-search-backward #インクリメンタルサーチを消さない
bindkey "^p" history-beginning-search-backward-end #サーチ機能を消さない
bindkey "^n" history-beginning-search-forward-end  #同上
#bindkey "^i" _list-expand-or-complete-word #タブは単語補完にする

## 補完設定
unsetopt list_types # 補完候補一覧でファイルの種別をマーク表示しない
unsetopt auto_menu # TAB で順に補完候補を切り替えない
setopt auto_list # 補完候補を一覧表示
setopt list_packed # 補完候補を詰めて表示
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
zstyle ':completion:*:default' menu select=1 # 補完候補のカーソル選択を有効に
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
setopt magic_equal_subst # --prefix=/usr などの = 以降も補完
setopt noautoremoveslash # 最後のスラッシュを自動的に削除しない


## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## 追加の設定読み込み
function load_in_zshrc(){
    if [[ -f $1 ]]; then
        source $1
    fi
}
load_in_zshrc ~/.zshrc.local
load_in_zshrc ~/dotfiles/.zsh/.zshrc.prompt
load_in_zshrc ~/dotfiles/.zsh/.zshrc.command

### Added by Zplugin's installer
source '/home/nakahashi/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk
load_in_zshrc ~/dotfiles/.zsh/.zshrc.zplugin
