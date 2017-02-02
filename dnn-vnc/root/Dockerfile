#
# dnn-vnc-root: Dockerfile for deep learning with Keras, Lasagne, ml-pyxis, and
# scikit-image using VNC (Virtual Network Computing).
#
# This Dockerfile ensures that the container starts as root.
#

# Base image is s locally built image of dnn-basic
FROM dnn-basic-root:latest


LABEL maintainer "Aleksander Rognhaugen and Igor Barros Barbosa"


# Run the following as `root`
USER root


# Install program for copy and paste, LXDE, VNC server, and xvfb (fake X11)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autocutsel \
        lxde-core \
        lxterminal \
        x11vnc \
        xvfb


# Install Firefox, htop, and pwgen
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    firefox \
    htop \
    pwgen


# Install dependencies for Atom
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libnotify4 \
    libnss3 \
    gvfs-bin \
    xdg-utils


# Install Atom
RUN wget https://github.com/atom/atom/releases/download/v1.12.2/atom-amd64.deb
RUN dpkg -i  ./atom-amd64.deb
RUN rm -f ./atom-amd64.deb


# Cleanup apt-get
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*


# Add script for running the VNC server
RUN mkdir /root/.vnc
COPY vnc.sh /root/.vnc/
RUN chmod +x /root/.vnc/vnc.sh && \
    echo "alias run_vnc=/root/.vnc/vnc.sh" \
    >> /root/.bash_aliases


# Configure VNC: set resolution and temporary default password
ENV VNC_PASSWORD pass1234
ENV RESOLUTION 1280x1024x16


# Expose port for VNC server
EXPOSE 5900


# Set default working directory and image startup command
WORKDIR "/root"
CMD ["/bin/bash"]
