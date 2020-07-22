#!/bin/sh

/usr/bin/amixer -q set Headphone 70%
/bin/systemctl restart mpd.service
/usr/bin/mpc play 1
