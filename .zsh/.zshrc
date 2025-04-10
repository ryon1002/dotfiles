## 補完機能の強化
autoload -Uz compinit

setopt nobeep # ビープを鳴らさない
setopt auto_cd # ディレクトリ名だけでcd
setopt auto_resume ## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
unsetopt promptcr ## 出力の文字列末尾に改行コードが無い場合でも表示
setopt correct ## スペルチェック
setopt ignoreeof ## ^D not log out
setopt NO_flow_control ## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt print_eight_bit ## 出力時8ビットを通す(日本語表示用？)
stty stop undef #Ctrl+Sを無効化

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
HISTSIZE=200000 # メモリに展開する履歴の数
SAVEHIST=100000 # 保存する履歴の数
setopt hist_ignore_all_dups # 履歴を重複して保時しないs
setopt hist_ignore_dups # 同じヒストリは登録しない
setopt hist_no_store # history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集
setopt share_history # ヒストリを共有
setopt hist_reduce_blanks #余計な空白を削除
setopt complete_in_word # 単語途中からの補完を許す
setopt always_to_end # 補完時に単語の後ろまでいく
setopt hist_ignore_space # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない

#bindkey -e
#bindkey "^o" menu-complete #Ctrl+oでメニュー選択
#bindkey "^q" push-line #Ctrl+qでコマンドラインスタック

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

export TERM=xterm-256color
if which nvim > /dev/null ; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

export XDG_CONFIG_HOME=~/.config
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Docker Build Kitを使う
export DOCKER_BUILDKIT=1

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

export ZVM_INIT_MODE=sourcing
eval "$(sheldon source)"
load_in_zshrc ~/dotfiles/.zsh/.zshrc.command
load_in_zshrc ~/dotfiles/.zsh/.zshrc.zplugin

eval "$(direnv hook zsh)"
eval "$(~/.local/bin/mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(starship init zsh)"
#source "$HOME/.rye/env"

export PATH="/usr/local/cuda/bin${PATH:+:${PATH}}"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

## キーバインドの設定(pluginとの競合を考えてここに置く)
bindkey "^o" menu-complete #Ctrl+oでメニュー選択
bindkey "^q" push-line #Ctrl+qでコマンドラインスタック
bindkey '^[[1;5D' backward-word #ctrlのワード移動
bindkey '^[[1;5C' forward-word #ctrlのワード移動

compinit
