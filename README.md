# MPD on the Raspberry Pi

This project installs [MPD](https://www.musicpd.org/) on the Raspberry Pi, copies the webradio playlist and starts playing. Endlessly.

Also it is possible to stream AirPlay to the Raspberry Pi via [shairport-sync](https://github.com/mikebrady/shairport-sync).

# Install

Use the `install.sh` script to install.
Follow the configure sections for adaptations.

The installation script is specifically made for a Raspberry Pi and tested on a Raspberry Pi 1 B.
On other systems you may have to adapt the installation.

## Configure automatic restart

The FRITZ!Box at home automatically resets the network connection at 5-6.
MPD is stuck after that and does not continue to play.
Shortly after that the mpd should be restarted in order to continue playback. This is currently done at 6:05 by a systemd service.

Changing the time can be done inside the `systemd/mpd-restart.timer` file.
Rerun the `install.sh` script in order to apply the change.
