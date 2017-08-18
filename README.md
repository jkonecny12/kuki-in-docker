Run Kuki TV in an Ubuntu container
===============================

Run Kuki TV from the NetBox internet provider in an Ubuntu container. This is useful if you have
one of the unsupported Linux distribution for this application.
Supported distributions are `Ubuntu`, `Debian`, `Arch Linux`.

Build Docker container
----------------------

``./build_docker.sh``


Run container
-------------

``sudo docker run -ti --rm -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USER/.kuki:/home/kuki/.kuki --privileged kuki``

or use `run_kuki.sh` script.

Enable Intel graphics card
--------------------------

You need to pass `DISPLAY` environment variable, `/tmp/.X11-unix` folder to the container
and the container have to be run as `--privileged` to enable XServer.
To save Kuki user settings you have to mount the `/home/$USER/.kuki` folder inside of container.

See below if you have NVidia graphics card.

Enable PulseAudio
-----------------

1) To enable PulseAudio it is required to install and run `paprefs` on a host.
   Launch paprefs (PulseAudio Preferences) > Network Server > [X] Enable network access to local sound devices.
2) Enable port 4713/tcp in your firewall to allow container to connect to host.


Note:
-----

Sound may work but it is muted. Press and hold `+` on numpad to increase application volume.


Enable NVIDIA graphics card
---------------------------

To enable NVIDIA graphics card inside of Docker, you have to install https://github.com/NVIDIA/nvidia-docker and run `nvidia-docker` instead of `docker` command.
Also you must uncomment NVIDIA part in the Dockerfile and comment Intel part there.

System integration
==================

1) Copy share folder:
    * If you want support for local user only: ~/.local/share
    * If you want system support /usr/share
2) Copy `run_kuki.sh` to `/usr/bin/kuki`.
3) Add ``%wheel  ALL=(root) NOPASSWD: /usr/bin/kuki`` to visudo after first `%wheel` directive.
4) Run docker on startup `systemctl enable docker-latest` (Fedora 25) or `systemctl enable nvidia-docker` if you have NVIDIA graphics card.

Future Work
===========

Use Flatpak instead of Docker.
