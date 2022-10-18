#!/usr/bin/env bash
set -eu

/usr/bin/mpc -q clear
/usr/bin/mpc -q update --wait
/usr/bin/mpc -q volume 20
/usr/bin/mpc -q load Chillout
#/usr/bin/mpc play 1
