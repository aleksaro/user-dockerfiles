#
# dnn-c9-root: Dockerfile for deep learning with Cloud9 (https://github.com/c9/core).
#
# This Dockerfile ensures that the container starts as root.
#

# Base image is a locally built image of dnn-basic
FROM dnn-basic-root:latest


LABEL maintainer "Aleksander Rognhaugen and Igor Barros Barbosa"


# Run the following as `root`
USER root


# Install Python 2.7 and Node.js
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        python2.7 \
        nodejs


# Cleanup apt-get
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*


# Install Cloud9
RUN git clone https://github.com/c9/core.git c9
RUN c9/scripts/install-sdk.sh


# Add Cloud9 shortcut
RUN echo "alias run_c9='nodejs c9/server.js --port 8181 --listen 0.0.0.0 '" \
    >> /root/.bash_aliases


# Expose port for Cloud9
EXPOSE 8181


# Set default working directory and image startup command
WORKDIR "/root"
CMD ["/bin/bash"]
