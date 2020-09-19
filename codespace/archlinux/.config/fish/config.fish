# Python
## Pyenv
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH
pyenv init - | source
## Pipenv
eval (pipenv --completion)
# Ruby
## Rvm
### Using `oh-my-fish/plugin-rvm`
# Node
## Nodenv
set -gx PATH $HOME/.nodenv/bin $PATH
~/.nodenv/bin/nodenv init
## Yarn
set -gx PATH $HOME/.yarn/bin $PATH
# Deno
## Dvm
### Alias become `denovm`
set -gx DENO_INSTALL $HOME/.deno
set -gx PATH $DENO_INSTALL/bin $PATH
set -gx DENOVM_DIR $HOME/.denovm
set -gx PATH $DENOVM_DIR/bin $PATH
# Go
## Goenv
set -gx GOENV_ROOT $HOME/.goenv
set -gx PATH $GOENV_ROOT/bin $PATH
eval (goenv init - | source)
set -gx PATH $GOROOT/bin $PATH
set -gx PATH $PATH $GOPATH/bin
# Java
## Jenv
set -gx PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)
# Php
## Phpenv
set -gx PATH $HOME/.phpenv/bin $PATH
eval (phpenv init -)
# Dart
## Dvm
if test -f ~/.dvm/scripts/dvm
    . ~/.dvm/scripts/dvm
end
# Rust
bass source $HOME/.cargo/env
# Perl
## Plenv
set -gx PATH $HOME/.plenv/bin $PATH
eval (plenv init - fish)

# User
## Function
function en2ja;curl -sL https://gist.github.com/koumaza/6026efd35025a7b634f8b8e47c43f5f6/raw/c14e39d34193f0ffdc893c97c65b9691a7c2bf9c/en2ja.fish.sh|env argv=$argv HOME=/tmp fish;end
function en2ja-int;while true;read intr -p "echo '|En |> Ja| :>> '";if test "$intr" = break;break;else if test "$intr" = exit;break;end;en2ja $intr;end;end
function ja2en;curl -sL https://gist.github.com/koumaza/6026efd35025a7b634f8b8e47c43f5f6/raw/c14e39d34193f0ffdc893c97c65b9691a7c2bf9c/ja2en.fish.sh|env argv=$argv HOME=/tmp fish;end
function ja2en-int;while true;read intr -p "echo '|Ja |> En| :>> '";if test "$intr" = break;break;else if test "$intr" = exit;break;end;ja2en $intr;end;end
## Alias
alias fish.=". ~/.config/fish/config.fish"
alias repo2sync="repo sync -c -j(math (nproc --all) \* 24) --force-sync --no-clone-bundle --no-tags"
function asshole; while true; for n in (seq 1 3); echo "Syncing..." && sudo nice -n18 sync && echo "Sync completed successfully"; echo "$n \> drop_caches" && echo Dropping: [(echo -ne $n |sudo nice -n18 tee /proc/sys/vm/drop_caches)] && echo "Drop-caches completed successfully"; sleep 1; end; end; end
alias l="ls"
alias b="bash -c"
alias v="vim"
alias n="nvim"
alias g="grep"
alias s="sync"
alias r="rm -rf"
alias m="mkdir -p"
alias C="chmod a+rx"
function mc; mkdir -p $argv ; cd $argv ; end
alias cf="env HOME=(mktemp -d) fish --login"
alias curlo="curl -LO"
## Prompt
function fish_prompt
        set -gx pstatus $status
        eval $GOPATH/bin/powerline-go \
        -modules user,aws,cwd,docker,dotenv,exit,hg,host,jobs,kube,nix-shell,node,perlbrew,perms,plenv,shenv,ssh,svn,termtitle,terraform-workspace,venv,vgo,root \
        -colorize-hostname \
        -condensed \
        -cwd-max-depth 10 \
        -cwd-max-dir-size -1 \
        -error $status \
        -git-assume-unchanged-size 4096 \
        -hostname-only-if-ssh \
        -path-aliases \$GOPATH/src/github.com=@GOPATH-GH,\~/work/projects/foo=@FOO,\~/work/projects/bar=@BAR \
        -shell bare
end
function fish_right_prompt
        set duration (math -s6 "$CMD_DURATION / 1000")
        eval $GOPATH/bin/powerline-go \
        -modules exit,git,duration,time,load \
        -condensed \
        -error $pstatus \
        -numeric-exit-codes \
        -static-prompt-indicator \
        -git-assume-unchanged-size 4096 \
        -duration $duration \
        -shell bare
end
