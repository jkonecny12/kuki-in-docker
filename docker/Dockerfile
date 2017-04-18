FROM ubuntu:16.04

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl

RUN curl http://linux.kuki.cz/kuki.pgp | apt-key add - && \
    echo "deb http://linux.kuki.cz/ xenial kuki" > /etc/apt/sources.list.d/kuki.list

RUN apt-get update && apt-get install -y kuki xserver-xorg-video-intel pulseaudio libcurl3
RUN apt-get install -fy

RUN apt-get install -y openssh-server

# Create OpenSSH privilege separation directory
RUN mkdir /var/run/sshd
RUN echo "\n\nCiphers +arcfour" >> /etc/ssh/sshd_config

# Add the Chrome user that will run the browser
RUN adduser --disabled-password --gecos "Kuki user" --uid 1000 kuki

# Replace 1000 with your user / group id
#RUN export uid=1000 gid=1000 && \
#    mkdir -p /home/dragon && \
#    echo "dragon:x:${uid}:${gid}:Dragon,,,:/home/dragon:/bin/bash" >> /etc/passwd && \
#    echo "dragon:x:${uid}:" >> /etc/group && \
#    chown ${uid}:${gid} -R /home/dragon/ && \
#    gpasswd -a dragon audio


# Add SSH public key for the chrome user
RUN mkdir /home/kuki/.ssh
ADD id_rsa.pub /home/kuki/.ssh/authorized_keys
RUN chown -R kuki:kuki /home/kuki/.ssh

# Set up the launch wrapper
RUN echo 'export PULSE_SERVER="tcp:localhost:64713"' >> /usr/local/bin/kuki-forward
RUN echo 'kuki' >> /usr/local/bin/kuki-forward
#RUN echo 'google-chrome --no-sandbox' >> /usr/local/bin/chrome-pulseaudio-forward
RUN chmod 755 /usr/local/bin/kuki-forward


#COPY pulse-client.conf /etc/pulse/client.conf

# Start SSH so we are ready to make a tunnel
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

#USER kuki
#ENV HOME /home/kuki

# Expose the SSH port
EXPOSE 22
#CMD /usr/bin/kuki
