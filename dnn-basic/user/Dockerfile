#
# dnn-basic-user: Basic Dockerfile for deep learning with scikit-image, Lasagne,
# Keras, and ml-pyxis with Jupyter.
#
# This Dockerfile ensures that the container starts as a user and *not* as root.
#

# Base image is python-theano-tf
FROM aleksaro/python3-theano-tf:latest


MAINTAINER Aleksander Rognhaugen


# Run the following as `root`
USER root


# Install Lasagne, Keras, and ml-pyxis
RUN pip3 install --upgrade \
    scikit-image \
    git+git://github.com/Lasagne/Lasagne.git@$master \
    git+git://github.com/fchollet/keras.git@$master \
    git+git://github.com/vicolab/ml-pyxis.git@$master


# Set correct locale for locale-aware programs or libraries
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


# Set basic environment variables
ENV NB_USER berserk
ENV NB_UID 1000
ENV HOME /home/$NB_USER


# Create `NB_USER` user with UID=NB_UID and in the `users` group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER


# Copy over `.theanorc` and `.bash_aliases` from /root and give ownership
RUN cp /root/.bash_aliases $HOME && \
    cp /root/.theanorc $HOME && \
    chown -R $NB_USER:users $HOME/.bash_aliases && \
    chown -R $NB_USER:users $HOME/.theanorc


# Switch to `NB_USER`
USER $NB_USER


# Set up home directory for `NB_USER`
RUN mkdir $HOME/shared && \
    mkdir $HOME/data && \
    mkdir $HOME/.jupyter && \
    mkdir $HOME/.misc && \
    mkdir -p -m 700 $HOME/.local/share/jupyter


# Switch to `root`
USER root


# Copy over configuration and run file for Jupyter
# The run file is because of: https://github.com/ipython/ipython/issues/7062
COPY jupyter_notebook_config.py $HOME/.jupyter/
COPY run_jupyter.sh $HOME/.jupyter/

# Ensure `.jupyter` is owned by`NB_USER`
RUN chown -R $NB_USER:users $HOME/.jupyter

# Make sure that the run file for jupyter is runnable + add shortcut
RUN chmod +x $HOME/.jupyter/run_jupyter.sh && \
    echo "alias run_jupyter=$HOME/.jupyter/run_jupyter.sh" \
    >> $HOME/.bash_aliases


# Add a script that makes it easier to update some packages
COPY upgrade_packages.sh $HOME/.misc/
RUN chmod +x $HOME/.misc/upgrade_packages.sh && \
    echo "alias upgrade_packages=$HOME/.misc/upgrade_packages.sh" \
    >> $HOME/.bash_aliases


# Expose port for IPython (8888)
EXPOSE 8888

# Expose port for TensorBoard (6006)
EXPOSE 6006


# Set default working directory and image startup command
WORKDIR $HOME
CMD ["/bin/bash"]


# Switch back to `NB_USER`
USER $NB_USER
