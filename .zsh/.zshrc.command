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

init_python_project(){
  if [ $# -gt 0 ]; then
    pname=$1
  else
    pname=`basename ${PWD}`
  fi
  python3 -m venv venv_$pname
  echo "source ${PWD}/venv_$pname/bin/activate" > .envrc
  echo "export PYTHONPATH=${PWD}" >> .envrc
  echo "unset PS1" >> .envrc
  direnv allow
}

xclip-buffer(){
    print -rn $BUFFER | xclip
    zle -M "copy to cb: ${BUFFER}"
}
 
zle -N xclip-buffer
bindkey '^b' xclip-buffer

## エイリアス・コマンド設定
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -a --color=auto'
alias su='su -c ${SHELL}'

alias -g G='| grep '
alias -g L='| less '
alias -g T='| tail -f  '
alias -s {gz,tgz,zip,bz2,tbz,tar}=extract
