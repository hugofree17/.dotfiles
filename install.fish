#!/usr/bin/fish

# Loads env vars and setup functions
if . inc/_load_env.fish -eq 0
    info "Found OS: $DOTFILES_SETUP_OS"
    info "Loading install script: _install_$DOTFILES_SETUP_OS.fish"

    # Loads OS specific install script
    . inc/_install_$DOTFILES_SETUP_OS.fish


    set -U DOTFILES_SETUP_DONE true
    exit 0
end
