#!/usr/bin/env bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Script for running an X11 VNC server.
#

function run_vnc {
    # Generate random password
    export VNC_PASSWORD=$(pwgen -c -n -1 8)
    echo "export VNC_PASSWORD=$VNC_PASSWORD" >> ~/.bashrc

    echo $VNC_PASSWORD | xargs -i x11vnc -storepasswd {} ~/.vnc/passwd
    Xvfb -screen 0 ${RESOLUTION} -ac &
    env DISPLAY=:0.0 x11vnc -forever -usepw  -tightfilexfer   -display :0 &
    env DISPLAY=:0.0 startlxde
}

run_vnc
# END
