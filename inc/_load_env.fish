#!/usr/bin/fish

set -x CLR_BLUE               (echo -en '\033[00;34m')
set -x CLR_GREEN              (echo -en '\033[00;32m')
set -x CLR_RESTORE            (echo -en '\033[0m')
set -x CLR_RED                (echo -en '\033[00;31m')
set -x CLR_WHITE              (echo -en '\033[01;37m')
set -x CLR_YELLOW             (echo -en '\033[01;33m')
set -x DOTFILES_ROOT_DIR      (dirname (pwd))
set -x DOTFILES_SETUP_OS      (uname)                   # Linux | Darwin
set -x DOTFILES_SETUP_DISTRO  (lsb_release -is)         # Ubuntu | Fedora
set -x DOTFILES_SETUP_VERSION (lsb_release -cs)         # bionic | xenial | trusty
set -x LOG_PREFIX             ".dotfiles:"

function _p
    echo "$CLR_WHITE""$LOG_PREFIX""$argv""$CLR_RESTORE"
end

function info
    _p "$CLR_BLUE""II""$CLR_WHITE"": $argv[1]"
end

function warn
    _p "$CLR_YELLOW""WW""$CLR_WHITE"": $argv[1]"
end

function err
    _p "$CLR_RED""EE""$CLR_WHITE"": $argv[1]"
end

if test $DOTFILES_SETUP_DONE
    err "Previous script run detected. Aborting to prevent conflicts."
    err "Clear \$DOTFILES_SETUP_DONE to re-run."
end
