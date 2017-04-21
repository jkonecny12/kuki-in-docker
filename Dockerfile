FROM ubuntu:16.04

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

###############
# GPU DRIVERS #
###############
# Use `ubuntu-drivers devices` in container first to get package recommendation.
# The `ubuntu-drivers` command is inside of `ubuntu-drivers-common` package.

# For intel GPU
#RUN apt-get install -y xserver-xorg-video-intel

# For nvidia use appropriate driver version
RUN apt-get install -y nvidia-375

#########
# AUDIO #
#########
RUN apt-get update && apt-get install -y pulseaudio

#######################
# INSTALL APPLICATION #
#######################
RUN apt-get install -y curl libcurl3 && \
    curl http://linux.kuki.cz/kuki.pgp | apt-key add - && \
    echo "deb http://linux.kuki.cz/ xenial kuki" > /etc/apt/sources.list.d/kuki.list
RUN apt-get install -y kuki

RUN apt-get install -fy

#################
# SYSTEM SET-UP #
#################

# Add the Kuki user
RUN adduser --disabled-password --gecos "Kuki user" --uid 1000 kuki

# Add executable kuki-pulse which will find ip of host and export it as PULSE_SERVER
# and then run kuki application
COPY kuki-pulse /usr/local/bin/kuki-pulse
RUN chmod 755 /usr/local/bin/kuki-pulse


USER kuki
ENV HOME /home/kuki

# Default application to run
CMD /usr/local/bin/kuki-pulse
