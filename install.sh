#!/bin/sh

# install mpd
sudo apt install -y mpd mpc shairport-sync

# copy playlists
sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

# just make sure mpd is running correctly
sudo systemctl restart mpd

# systemd
sudo cp -uv systemd/* /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable mpd-restart.timer
sudo systemctl start mpd-restart.timer

# system-scripts
sudo mkdir -p /usr/lib/mpd-pi
sudo cp -uv scripts/* /usr/lib/mpd-pi

# shairport-sync config
sudo cp -uv shairport-sync.conf /etc/shairport-sync.conf
sudo systemctl restart shairport-sync.service

# start default stream
mpc -q update --wait
mpc -q clear
mpc -q load Chillout
mpc -q volume 100
mpc play
