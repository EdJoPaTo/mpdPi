# MPD on the Raspberry Pi

This project installs [MPD](https://www.musicpd.org/) on the Raspberry Pi, copies the webradio playlist and starts playing. endlessly.

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
