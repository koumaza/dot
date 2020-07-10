# Env
# Path
set -gx PATH ~/bin $PATH
# Alias
alias fish.=". ~/.config/fish/config.fish"
alias repo2sync="repo sync -c -j(math (nproc --all) \* 24) --force-sync --no-clone-bundle --no-tags"
function osstinpois;    echo 'mkdir -p ~/log/$(pwd|tr / _|sed -E s/^_//) && mka bacon -j$(($(nproc --all) * 24)) | tee ~/log/$(pwd|tr '/' '_'|sed -E 's/^_//')/$(date '+%Z_%m%d-%H:%M:%S.%N'.log)'; end
function asshole; while true; echo "Syncing..."; sudo nice -n18 sync; echo "Sync completed successfully"; echo "1 \> drop_caches"; echo Dropping: [(echo -ne 1 |sudo nice -n18 tee /proc/sys/vm/drop_caches)]; echo "Drop-caches completed successfully"; sleep 10; echo "Syncing..."; sudo nice -n18 sync; echo "Sync completed successfully";: '#echo "2 \> drop_caches" #echo Dropping: [(echo -ne 2 |sudo nice -n18 tee /proc/sys/vm/drop_caches)] #echo "Drop-caches completed successfully" #sleep 10'; end; end
alias l="ls"
alias b="bash -c"
alias v="vim"
alias n="nvim"
alias s="sync"
alias r="rm -rf "
alias m="mkdir -p"
function cm; mkdir -p $argv ; cd $argv ; end
alias cf="env HOME=(mktemp -d) fish --login"
