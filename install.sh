#!/bin/sh

sudo apt install mpd mpc

sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

mpc -q update --wait
mpc -q load Chillout
mpc play
