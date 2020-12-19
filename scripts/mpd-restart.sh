#!/bin/sh

/bin/systemctl restart mpd.service
/usr/bin/mpc -q clear
/usr/bin/mpc -q update --wait
/usr/bin/mpc -q volume 70
/usr/bin/mpc -q load Chillout
/usr/bin/mpc play 1
