#!/bin/sh

/bin/systemctl restart mpd.service
/usr/bin/mpc volume 70
/usr/bin/mpc play 1
