#!/bin/sh

# install mpd
sudo apt install -y mpd mpc shairport-sync

# copy playlists
sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

# copy systemd units
sudo cp -uv systemd/* /etc/systemd/system

# reload systemd
sudo systemctl daemon-reload

# start automatic restart timer
sudo systemctl enable mpd-restart.timer
sudo systemctl start mpd-restart.timer

# start default stream
mpc -q update --wait
mpc -q load Chillout
mpc -q volume 100
mpc play
