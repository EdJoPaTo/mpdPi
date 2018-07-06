#!/bin/sh

sudo apt install mpd mpc

sudo cp playlists/* /var/lib/mpd/playlists/
sudo chown -R mpd:audio /var/lib/mpd/

mpc update --wait
mpc load Chillout
mpc play
