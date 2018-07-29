# MPD on the Raspberry Pi

This project installs [MPD](https://www.musicpd.org/) on the Raspberry Pi, copies the webradio playlist and starts playing. endlessly.

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

## Configure shairport-sync

[shairport-sync](https://github.com/mikebrady/shairport-sync) allows the Pi to be AirPlay Target.
In order to stop the mpd playback while using it as an AirPlay target use the following settings in `/etc/shairport-sync.conf`:

```
sessioncontrol =
{
  run_this_before_play_begins = "/usr/bin/mpc stop";
  run_this_after_play_ends = "/usr/bin/mpc play";
}
```
