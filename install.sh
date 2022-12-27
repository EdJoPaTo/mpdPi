#!/usr/bin/env bash
set -eux

# install mpd
sudo apt-get install -y mpd mpc shairport-sync

# copy playlists
sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

# just make sure mpd is running correctly
sudo systemctl restart mpd.service

# download mpd-internetradio-destuck
wget -q --show-progress -O mpd-internetradio-destuck.deb \
	https://github.com/EdJoPaTo/mpd-internetradio-destuck/releases/download/v0.2.5/mpd-internetradio-destuck-v0.2.5-aarch64-unknown-linux-gnu.deb
sudo dpkg -i mpd-internetradio-destuck.deb

# system-scripts
sudo mkdir -p /usr/local/lib/mpd-pi/
sudo cp -v scripts/* /usr/local/lib/mpd-pi/

# systemd
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -v systemd/* /usr/local/lib/systemd/system/
sudo systemctl daemon-reload

# Start systemd services
sudo systemctl enable --now mpd-internetradio-destuck.service
sudo systemctl enable --now mpd-restart.timer

# shairport-sync config
sudo cp -v shairport-sync.conf /etc/shairport-sync.conf
sudo systemctl restart shairport-sync.service

/usr/local/lib/mpd-pi/mpd-restart.sh
