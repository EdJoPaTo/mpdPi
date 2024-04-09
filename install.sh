#!/usr/bin/env bash
set -eux

# install mpd
sudo apt-get install -y mpd mpc shairport-sync

# Stop while updating configs
sudo systemctl stop shairport-sync.service
sudo systemctl disable --now mpd.service
systemctl --user stop mpd.service

wget -q --show-progress -O /tmp/mpd-internetradio-destuck.deb \
	https://github.com/EdJoPaTo/mpd-internetradio-destuck/releases/download/v0.2.6/mpd-internetradio-destuck-v0.2.6-aarch64-unknown-linux-gnu.deb
sudo dpkg -i /tmp/mpd-internetradio-destuck.deb

sudo cp -v shairport-sync.conf /etc/shairport-sync.conf

mkdir -p \
	"$HOME/.cache/mpd/" \
	"$HOME/.config/mpd/playlists/" \
	"$HOME/.config/systemd/user/" \
	"$HOME/.local/share/mpd-pi/" \
	"$HOME/Music"

cp -v mpd.conf "$HOME/.config/mpd/"
cp -v playlists/* "$HOME/.config/mpd/playlists/"
cp -v scripts/* "$HOME/.local/share/mpd-pi/"
cp -v systemd/* "$HOME/.config/systemd/user/"

systemctl --user daemon-reload

# Start systemd services
systemctl --user enable --now mpd.service
systemctl --user enable --now mpd-nighttime.timer
systemctl --user enable --now mpd-restart.timer
sudo systemctl enable --now mpd-internetradio-destuck.service
sudo systemctl enable --now shairport-sync.service

# keep systemd user context after logout and load on boot
loginctl enable-linger

"$HOME/.local/share/mpd-pi/mpd-restart.sh"
