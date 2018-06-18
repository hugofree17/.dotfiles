#!/usr/bin/fish

# Non-launchpad ppads need. App name + key + repo-
set -l _eppa      "Docker" "Spotify" "Virtualbox"
set -l _eppakeys  "9DC858229FC7DD38854AE2D88D81803C0EBFCD88" \
                  "0DF731E45CE24F27EEEB1450EFDC8610341D9410" \
                  "B9F8D658297AF3EFC18D5CDFA2F683C52980AECF"
set -l _epparepos "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DOTFILES_SETUP_VERSION stable" \
                  "deb http://repository.spotify.com stable non-free" \
                  "deb https://download.virtualbox.org/virtualbox/debian $DOTFILES_SETUP_VERSION contrib"

# Packages names for apt installing later
set -l _packages "curl" \
                 "dbeaver-ce" \
                 "docker-ce" \
                 "git" \
                 "htop" \
                 "network-manager-openconnect-gnome" \
                 "peek" \
                 "spotify-client" \
                 "vim" \
                 "virtualbox"

# Extra launchpad ppas needed
set -l _lppa "openconnect/daily" \
             "peek-developers/stable" \
             "serge-rider/dbeaver-ce"

function addExternalPpa
    warn "Installing gpg key for $argv[1]"
    err  "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $argv[2]"
    info "Adding repo for $argv[1]"
    err  "echo $argv[3] | sudo tee /etc/apt/sources.list.d/$argv[1].list"
end

function addPpa
    info "Adding $argv[1]"
    err  "sudo add-apt-repository $argv[1]"
end

info "Adding extra PPAs. Will require sudo."
for repo in $_lppa
    addPpa $repo
end

info "Setting up external PPAs."
for key in $_eppa
    if set -l idx (contains -i -- $key $_eppa)
        addExternalPpa $key $_eppakeys[$idx] $_epparepos[$idx]
    end
end

info "Upgrading base os packages"
err  "sudo apt update; sudo apt upgrade -y"

info "Installing packages: $_packages"
err  "sudo apt install -y $_packages"
