# Python
## Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
## Pipenv
eval "$(pipenv --completion)"
# Ruby
## Rvm
source $HOME/.rvm/scripts/rvm
# Node
## Nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
~/.nodenv/bin/nodenv init
## Yarn
export PATH="$HOME/.yarn/bin:$PATH"
# Deno
## Dvm
### Alias become `denovm`
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH
export DENOVM_DIR=$HOME/.denovm
export PATH=$DENOVM_DIR/bin:$PATH
# Go
## Goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
# Java
## Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
# Php
## Phpenv
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"
# Dart
## Dvm
if [[ -f ~/.dvm/scripts/dvm ]]; then
    . ~/.dvm/scripts/dvm
fi
# Rust
## Rustup
source $HOME/.cargo/env

# User
## Prompt
## Alias
