# MPD on the Raspberry Pi

This project installs [MPD](https://www.musicpd.org/) on the Raspberry Pi, copies the web radio playlist and starts playing. Endlessly.

Also, it is possible to stream AirPlay to the Raspberry Pi via [shairport-sync](https://github.com/mikebrady/shairport-sync).

# Install

Use the `install.sh` script to install.
Follow the configure sections for adaptations.

The installation script is specifically made for a Raspberry Pi and tested on a Raspberry Pi 3B with 32-bit Raspberry Pi OS.
On other systems you may have to adapt the installation.

## Allow usage of `mpc volume`

`mpc volume` does not seem to work out of the box.
Find the control you want to set via `amixer scontents`.

For the AUX on the Raspberry this is 'Headphone':
```plaintext
Simple mixer control 'Headphone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback -10239 - 400
  Mono: Playback -2791 [70%] [-27.91dB] [on]
```

For the HiFiBerry Amp2 this is 'Digital':
```plaintext
Simple mixer control 'Digital',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 207
  Mono:
  Front Left: Playback 104 [50%] [-51.50dB] [on]
  Front Right: Playback 104 [50%] [-51.50dB] [on]
```

Set this control in the `/etc/mpd.conf`:
```plain
audio_output {
        type            "alsa"
        name            "My ALSA Device"
#       device          "hw:0,0"        # optional
#       mixer_device    "default"       # optional
        mixer_control   "Headphone"
}
```


(Sadly I had no luck setting that controller as Alsa default in order to let MPD autodetect it. Hints welcome!)

## Configure automatic restart

The FRITZ!Box at home automatically resets the network connection at 5-6.
MPD is stuck after that and does not continue to play.
Shortly after that the mpd should be restarted in order to continue playback. This is currently done at 6:05 by a systemd service.

Changing the time can be done inside the `systemd/mpd-restart.timer` file.
Rerun the `install.sh` script in order to apply the change.

[mpd-internetradio-destuck](https://github.com/EdJoPaTo/mpd-internetradio-destuck) fixes the same issue but independently of time.
The `install.sh` script downloads the deb package for Raspberry Pi 1 and later (ARMv6).
When running an arm64 build of your OS adapt the download link in the `install.sh`.
ARMv7 (32 bit) should work just fine with the ARMv6 executable.

## Know Issues

When `shairport-sync` is running, the volume is set higher in order to be able to adjust the volume from the AirPlay source.
When the pi is rebooted while it's playing via AirPlay and gets restarted, the volume is still high.
The internet radio after the next startup WILL be loud.
