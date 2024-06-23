#!/usr/bin/env bash

# defaults
# ========

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
#export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/comfy/.local/share/flatpak/exports/share"
export XDG_STATE_HOME=$HOME/.local/state
export XDG_APP_HOME=/opt

export TERMINAL="${TERMINAL:-kitty}"
export COLORTERM=truecolor
export TERM="xterm-256color"
[[ "${0##*/}" == "bash" || "${0##*/}" == "zsh" ]] && export SHELL="$(which $0)"
export SHELL_NAME="${SHELL##*/}"
export player="mpd"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

PATH=/usr/local/bin:$PATH

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[[ -d "$XDG_DATA_HOME/busybox/bin" ]] && PATH="$PATH:$XDG_DATA_HOME/busybox/bin"

export PATH="$PATH"

export ZDOTDIR=$HOME/.config/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# kitchen
# =======

export KITCHEN="/home/kitchen"
export CONFIGPATH="$HOME/.dots"

[[ -d "$KITCHEN/bin" ]] && PATH=$KITCHEN/bin:$PATH

[[ -d "$HOME/llvm-project/build/bin" ]] && PATH="$PATH:$HOME/llvm-project/build/bin"
export PATH="$PATH:$XDG_APP_HOME/llvm/bin"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$XDG_APP_HOME/llvm/share"

export PATH="$PATH:$XDG_APP_HOME/odin"

[[ -f "$CONFIGPATH/make.conf" ]] && source "$CONFIGPATH/make.conf"

# applications
# ============

# go

export GOPATH="$XDG_APP_HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# deno

export DENO_INSTALL="$XDG_APP_HOME/deno"
export PATH="$PATH:$DENO_INSTALL/bin"

# bun

export BUN_INSTALL="$XDG_APP_HOME/bun"
export PATH="$PATH:$BUN_INSTALL/bin"

# cargo

export RUSTUP_HOME="$XDG_APP_HOME/rustup"
export CARGO_HOME="$XDG_APP_HOME/cargo"
export PATH="$PATH:$RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/bin:$CARGO_HOME/bin"
[[ -f "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"

# hayashi

# export PATH="$PATH:$HOME/.hayashi/pack/bin"
[[ -x "$HOME/.hayashi/pack/bin/hayashi" ]] && eval "$($HOME/.hayashi/pack/bin/hayashi env)"
[[ -x "$HOME/.saku/root/bin/sk" ]] && eval "$($HOME/.saku/root/bin/sk env)"

# fzf

case $SHELL_NAME in
  zsh) eval $(fzf --zsh) ;;
  bash) eval $(fzf --bash) ;;
esac

# rbenv

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# nvm

[[ -f "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"

export LAKE_DIR="$KITCHEN/botanic"

export SOFT_SERVE_DATA_PATH="$XDG_DATA_HOME/soft-serve"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
