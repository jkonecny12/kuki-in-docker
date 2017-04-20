FROM ubuntu:16.04

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl

# Install kuki tv
RUN curl http://linux.kuki.cz/kuki.pgp | apt-key add - && \
    echo "deb http://linux.kuki.cz/ xenial kuki" > /etc/apt/sources.list.d/kuki.list

# Install pulseaudio xserver and missing dependency libcurl3
RUN apt-get update && apt-get install -y kuki xserver-xorg-video-intel pulseaudio libcurl3
RUN apt-get install -fy

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
