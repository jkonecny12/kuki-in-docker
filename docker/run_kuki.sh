#!/bin/bash

sudo docker run -ti --rm -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USER/.kuki:/home/kuki/.kuki --privileged kuki
#sudo docker run -d -v /home/$USER/.kuki:/home/kuki/.kuki -p 127.0.0.1:2222:22 kuki
