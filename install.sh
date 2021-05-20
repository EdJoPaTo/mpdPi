#!/usr/bin/env bash
set -e

# install mpd
sudo apt-get install -y mpd mpc shairport-sync

# copy playlists
sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

# just make sure mpd is running correctly
sudo systemctl restart mpd.service

# download mpd-internetradio-destuck
wget -q --show-progress -O - https://github.com/EdJoPaTo/mpd-internetradio-destuck/releases/download/v0.2.3/mpd-internetradio-destuck-v0.2.3-armv7-unknown-linux-gnueabihf.tar.gz | tar xz

# system-scripts
sudo mkdir -p /usr/local/lib/mpd-pi/
sudo cp -uv scripts/* /usr/local/lib/mpd-pi/

# systemd
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -uv systemd/* /usr/local/lib/systemd/system/
sudo systemctl daemon-reload

# install mpd-internetradio-destuck
sudo systemctl stop mpd-internetradio-destuck.service
sudo cp -uv mpd-internetradio-destuck /usr/local/bin/

# Start systemd services
sudo systemctl enable --now mpd-internetradio-destuck.service
sudo systemctl enable --now mpd-restart.timer

# shairport-sync config
sudo cp -uv shairport-sync.conf /etc/shairport-sync.conf
sudo systemctl restart shairport-sync.service

/usr/local/lib/mpd-pi/mpd-restart.sh
