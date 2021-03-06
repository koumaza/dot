# Env
git config --global ghq.root $HOME/repo
set -gx GOPATH ~/go
set -gx GEMPATH ~/.gem/ruby/*
set -gx GEMBINPATH (echo $GEMPATH|sed -e "s/ /\/bin /g" -e 's/$/\/bin /g')
set -gx FISHCONFIG ~/.config/fish/config.fish
set -gx EDITOR nvim
set -gx NVM_DIR ~/.config/nvm
# Path
set -gx PATH ~/bin ~/.bin $GOPATH/bin $RUBYPATH $GEMBINPATH $PATH
# Alias
alias fish.=". ~/.config/fish/config.fish"
alias repo2sync="repo sync -c -j(math (nproc --all) \* 24) --force-sync --no-clone-bundle --no-tags"
function asshole; while true; for n in (seq 1 3); echo "Syncing..." && sudo nice -n18 sync && echo "Sync completed successfully"; echo "$n \> drop_caches" && echo Dropping: [(echo -ne $n |sudo nice -n18 tee /proc/sys/vm/drop_caches)] && echo "Drop-caches completed successfully"; sleep 1; end; end; end
function updatefishconfig; curl -Ls https://raw.githubusercontent.com/koumaza/dot/default/linux/fish/config.fish | tee ~/.config/fish/config.fish >/dev/null; fish.; end
alias l="ls"
alias b="bash -c"
alias v="vim"
alias n="nvim"
alias g="grep"
alias s="sync"
alias r="rm -rf"
alias m="mkdir -p"
alias C="chmod a+rx"
function cm; mkdir -p $argv ; cd $argv ; end
alias cf="env HOME=(mktemp -d) fish --login"
alias curlo="curl -LO"
function fishconfig; $EDITOR $FISHCONFIG; fish.; end
function repofind; yes ''|cd ~/repo/(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 (ghq root)/{}/README*"); end
function en2ja
  curl -sL https://gist.github.com/koumaza/6026efd35025a7b634f8b8e47c43f5f6/raw/c14e39d34193f0ffdc893c97c65b9691a7c2bf9c/en2ja.fish.sh|env argv=$argv HOME=/tmp fish
end
function en2ja-int
  while true
    read intr -p "echo '|En |> Ja| :>> '"
    if test "$intr" = break
      break
    else if test "$intr" = exit
      break
    end
    en2ja $intr
  end
end
function ja2en
  curl -sL https://gist.github.com/koumaza/6026efd35025a7b634f8b8e47c43f5f6/raw/c14e39d34193f0ffdc893c97c65b9691a7c2bf9c/ja2en.fish.sh|env argv=$argv HOME=/tmp fish
end
function ja2en-int
  while true
    read intr -p "echo '|Ja |> En| :>> '"
    if test "$intr" = break
      break
    else if test "$intr" = exit
      break
    end
    ja2en $intr
  end
end
# Keybind
function fish_user_key_bindings
  bind \cg repofind
end
# Fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
# Prompt
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
