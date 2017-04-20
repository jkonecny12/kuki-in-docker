Run Kuki TV in Ubuntu container
===============================

Run Kuki TV from NetBox internet provider in ubuntu container. This is useful if you have
unsupported Linux distribution. Supported distributions are `Ubuntu`, `Debian`, `Arch Linux`.

Build Docker container
----------------------

``sudo docker build -t kuki .``


Run container
-------------

``sudo docker run -ti --rm -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USER/.kuki:/home/kuki/.kuki --privileged kuki``

or use `run_kuki.sh` script.


To enable XServer it is required to have `DISPLAY` environment variable, `/tmp/.X11-unix` folder and `--privileged` inside of the container.
To save Kuki settings it is required to have /home/$USER/.kuki folder inside of container.

Enable PulseAudio
-----------------

1) To enable PulseAudio it is required to install and run `paprefs` on a host. Launch paprefs (PulseAudio Preferences) > Network Server > [X] Enable network access to local sound devices.
2) Enable port 4713/tcp in your firewall to allow container to connect to host.


Note:
-----

Sound may work but it is muted. Press and hold `+` on numpad to increase application volume.



System integration
==================

1) Copy share folder:
    * If you want support for local user only: ~/.local/share
    * If you want system support /usr/share
2) Copy run_kuki.sh to /usr/bin/kuki .
3) Add ``%wheel  ALL=(root) NOPASSWD: /usr/bin/kuki`` to visudo after first `%wheel` directive.
4) Run docker on startup `systemctl enable docker-latest` (Fedora 25).
