#!/bin/sh

# prepare a desktop/laptop with github.com/namato/dotfiles
#
# assumes Ubuntu 16.04 and sudo access
#
# also good to ensure that any existing installation of i3wm is not running
# at the time this is run

# install prerequisites and essential packages
sudo add-apt-repository ppa:aguignard/ppa
sudo apt-get update
sudo apt-get -y install wget
sudo apt-get -y install libxcb-xrm-dev
sudo apt-get -y install git libxcb1-dev libxcb-keysyms1-dev \
    libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev \
    libyajl-dev libstartup-notification0-dev libxcb-randr0-dev \
    libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    autoconf vim-nox
sudo apt-get -y install compton google-chrome-stable workrave i3blocks
sudo apt-get -y install fonts-font-awesome fonts-hack-ttf
git clone https://github.com/namato/dotfiles
git clone https://www.github.com/Airblader/i3 i3-gaps

# build/install i3-gaps
(cd i3-gaps && autoreconf --force --install && \
	mkdir -p build && cd build && \
	../configure --prefix=/usr --sysconfdir=/etc \
	--disable-sanitizers && \
	make && \
	sudo make install)

# get variety
sudo add-apt-repository ppa:peterlevi/ppa
sudo apt-get update
sudo apt-get install variety variety-slideshow

# get spotify
sudo apt-key adv --keyserver \
    hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | \
    sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# ohsnap font
(cd /tmp && wget -O- https://sourceforge.net/projects/osnapfont/files/latest/download?source=directory | \
	tar xvfz -)
sudo mkdir -p /usr/share/myfonts
sudo mv /tmp/myfonts/ohsnap-1.8.0 /usr/share/myfonts/
(cd /usr/share/myfonts/ohsnap-1.8.0 && sudo mkfontdir && \
	sudo xset +fp /usr/share/fonts/myfonts/ohsnap-1.8.0)
sudo xset fp rehash

# dropbox
wget -O /tmp/db.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
sudo dpkg -i /tmp/db.deb
rm -f /tmp/db.deb

# position conf files
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3blocks
mkdir -p ~/.config/i3status
(cd dotfiles && \
    cp i3/config ~/.config/i3/ && \
    cp i3blocks/i3blocks.conf ~/.config/i3blocks/ && \
    cp -R i3blocks/scripts ~/.config/i3blocks && \
    cp i3status/config ~/.config/i3status/ && \
    cp vim/vimrc ~/.vimrc)
