#!/usr/bin/env bash

set -e

# -- variables --

# DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
# WALLCTL_DIR="$DATA_DIR/wallctl"
#
# mkdir -p "$WALLCTL_DIR"
#
# BIN_FILE="$WALLCTL_DIR/.wallpaperset"
# ENV_FILE="$WALLCTL_DIR/.wallpaperenv"

# -- utils --

notify() {
    [[ -z "$XDG_CURRENT_DESKTOP" ]] && msg $1 || notify-send "$@"
}

msg() {
    printf "\033[32;1m%s\033[m %s\n" "$PROMPT" "$*"
}

warn() {
    >&2 printf "\033[33;1m%s \033[mwarning: %s\n" "$PROMPT" "$*"
}

die() {
    >&2 printf "\033[31;1m%s \033[merror: %s\n" "$PROMPT" "$*"
    exit 1
}

has() {
  command -v $1 2>&1 >/dev/null
}

confirm() {
    >&2 printf "\033[33;1m%s \033[mconfirm? %s" "$PROMPT" "$CONFIRM_PROMPT"
    read -r ans
    if [ "$ans" != y ] ; then
        >&2 printf '%s\n' 'Exiting.'
        exit
    fi
}

# -- usage --

usage() {
>&2 cat <<"EOF"
     [full]  - run update and upgrade system & home
   [update]  - update channels and flake
  [upgrade]  - upgrade [system|home]
      [all]  - rebuild system & home
   [system]  -  rebuild system
     [home]  -  rebuild home
EOF
exit 1
}

# -- main --

main() {
  [ "$1" ] || usage

  flag=${1#-}
  shift

  case $flag in
        full) main update system &&\
          main upgrade home ;;
        update) nix-channel --update &&\
          nix-env -u '*' &&\
          nix flake update ;;
        upgrade) 
          _flag=${1#-}
          shift
          case $_flag in
            system) main system $@ --upgrade ;;
            home) main home $@ --refresh ;;
            *) die "nothing specified to upgrade" ;;
          esac
          ;;
        all) main system &&\
          main home ;;
        system) rebuild_system $@ ;;
        home) rebuild_home $@ ;;
        *) die "command does not exist" ;;
  esac
}

rebuild_system() {
  has nh && {
    nh os switch . -- --show-trace $@
  } || {
    sudo nixos-rebuild --flake .#$(hostname) switch --show-trace $@
  } && notify "succesfully rebuild system" || notify "error while rebuilding system" -u critical
}
rebuild_home() {
  has nh && {
    nh home switch . -- --show-trace $@
  } || {
    home-manager --flake .#$(whoami) switch --show-trace $@
  } && notify "succesfully rebuild home" || notify "error while rebuilding home" -u critical
}

main $@
