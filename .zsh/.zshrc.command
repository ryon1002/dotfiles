## 独自Function
#展開
function extract() {
  case $1 in
    *.tar) tar xvf $1;;
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.zip) unzip $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
  esac
}

quote_and_escape() {
    # echo "$1" | sed 's/"/\\"/g; s/^/"/; s/$/"/'
  while IFS= read -r line; do
    escaped_line="${line//\"/\\\"}"
    printf "\"%s\"\n" "$escaped_line"
  done
}

init_python_project(){
  if [ $# -gt 0 ]; then
    pname=$1
  else
    pname=`basename ${PWD}`
  fi
  python3 -m venv venv_$pname
  echo "source ${PWD}/venv_$pname/bin/activate" > .envrc
  # echo "layout python" >> .envrc
  echo "export PYTHONPATH=${PWD}" >> .envrc
  echo "unset PS1" >> .envrc
  direnv allow
  # ln -s ".direnv/$(basename $VIRTUAL_ENV)/" venv
}

xclip-buffer(){
    print -rn $BUFFER | xclip
    zle -M "copy to cb: ${BUFFER}"
}
zle -N xclip-buffer
bindkey '^b' xclip-buffer

run_on_tmux_panes_h(){
  if [ $# -gt 0 ]; then
    command="tmux new-window "`head -n 1 $1`"; "
    tail -n +2 $1 | while read line
    do
      command=${command}"tmux split-window -h "$line"; "
    done
    command=${command}"tmux set-window-option synchronize-panes; tmux select-layout even-horizontal"
    eval $command
  fi
}

run_on_tmux(){
  local -A opts

  # オプション解析
  zparseopts -D -E -A opts d:

  if [ $# -gt 0 ]; then
    if [[ -n ${opts[(i)-d]} ]]; then
      command="tmux new-window -t ${opts[-d]} "$1"; "
    else
      command="tmux new-window "$1"; "
    fi
    for cmd in "${@:2}"; do
      command=${command}"tmux split-window "$cmd"; "
    done
    command=${command}"tmux select-layout even-horizontal"
    eval $command
  fi
}

## エイリアス・コマンド設定
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -a --color=auto'
alias su='su -c ${SHELL}'
alias vim='nvim'
alias my_pycharm='run_on_tmux -d 99 pycharm-professional'

alias -g G='| grep '
alias -g L='| less '
alias -g T='| tail -f  '
alias -s {gz,tgz,zip,bz2,tbz,tar}=extract
