#!/bin/sh

# install mpd
sudo apt install -y mpd mpc shairport-sync

# copy playlists
sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

# just make sure mpd is running correctly
sudo systemctl restart mpd.service

# install mpd-internetradio-destuck
wget -q --show-progress -O mpd-internetradio-destuck.zip https://github.com/EdJoPaTo/mpd-internetradio-destuck/releases/download/v0.1.0/mpd-internetradio-destuck-armv7-unknown-linux-gnueabihf.zip
unzip -f mpd-internetradio-destuck.zip
rm -f mpd-internetradio-destuck*.zip
chmod +x mpd-internetradio-destuck
sudo cp -uv mpd-internetradio-destuck /usr/local/bin/

# system-scripts
sudo mkdir -p /usr/lib/mpd-pi
sudo cp -uv scripts/* /usr/lib/mpd-pi

# systemd
sudo cp -uv systemd/* /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now mpd-internetradio-destuck.service
sudo systemctl enable --now mpd-restart.timer

# shairport-sync config
sudo cp -uv shairport-sync.conf /etc/shairport-sync.conf
sudo systemctl restart shairport-sync.service

/usr/lib/mpd-pi/mpd-restart.sh
