#!/usr/bin/env bash
dl="AT+FUS?"
binarydl="AT+SUDDLMOD=0,0"

echo $$1 > /dev/ttyACM0