# editor config
if [ -z "$EDITOR" ]; then
    export EDITOR="nvim"
fi
if [ -z "$VISUAL" ]; then
    export VISUAL="$EDITOR"
fi
if [ -z "$GIT_EDITOR" ]; then
    export GIT_EDITOR="$EDITOR"
fi

export GEM_HOME=/workspace/.rvm
export GEM_PATH=$GEM_HOME:$GEM_PATH
export PATH=/workspace/.rvm/bin:$PATH

export PIPENV_VENV_IN_PROJECT=true
export PIP_USER=yes
export PYTHONUSERBASE=/workspace/.pip-modules
export PATH=$PYTHONUSERBASE/bin:$PATH
unset PIP_TARGET
unset PYTHONPATH

if [ -d /workspace ]; then
    export CARGO_HOME=/workspace/.cargo
    export PATH=$CARGO_HOME/bin:$PATH
fi
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
shopt -s globstar
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
export PATH="$PATH:$HOME/.rvm/bin"

cat<<-'EOF'>~/.bash-android.rc
sudo /koumazainit >/dev/null 2>/dev/null
export origpwd=$PWD
if [ -n "$aftercd" ]; then
  cd $aftercd
fi
function build {
  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope >/dev/null 
  export cpuj=$1
  if [ -z "$cpuj" ]; then
  export cpuj="12"
  fi
  echo '>> . build/envsetup.sh'
  read -p '>> lunch ' device_codename_value
  export device_codename_value=$device_codename_value
  . build/envsetup.sh && \
  lunch $device_codename_value && \
  echo '>> mka bacon' && \
  mkdir -p ~/log/$(pwd|tr / _|sed -E s/^_//) && \
  mka bacon -j$(($(nproc --all) * $cpuj)) | tee ~/log/$(pwd|tr / _|sed -E s/^_//)/$(date +%Z_%m%d-%H:%M:%S.%N.log)
}
function cdir {
  cd $origpwd/$*
}
function help {
  echo -e 'Usage: > [build,cdir,clean,help,exit,sync,{make [clean,clobber]}]'"\n"'cdir == change directory'"\n"'clean == "make clean" and "make clobber"'"\n"'sync == repo sync'
}
function exit {
  exit
}
function make {
  . build/envsetup.sh
  make $*
}
function clean {
  . build/envsetup.sh
  make clean
  make clobber
}
function sync {
  fish -c repo2sync
}

EOF

abss() {
export origpwd=$PWD
export aftercd=$1
bash --init-file ~/.bash-android.rc
}
export -f abss
