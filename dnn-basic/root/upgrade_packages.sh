#/usr/bin/env bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Script for simplifying the act of installing/upgrading selected packages.
#

function upgrade_packages () {
    if [ -z "$1" ]; then
        echo "No argument supplied. Try 'help'."
        exit 1
    elif [ $1 = 'theano' ]; then
        echo 'Upgrading Theano...'
        pip3 install --upgrade git+git://github.com/Theano/Theano.git@master
    elif [ $1 = 'lasagne' ]; then
        echo 'Upgrading Lasagne...'
        pip3 install --upgrade git+git://github.com/Lasagne/Lasagne.git@$master
    elif [ $1 = 'keras' ]; then
        echo 'Upgrading Keras...'
        pip3 install --upgrade git+git://github.com/fchollet/keras.git@$master
    elif [ $1 = 'ml-pyxis' ]; then
        echo 'Upgrading ml-pyxis...'
        pip3 install --upgrade git+git://github.com/vicolab/ml-pyxis.git@$master
    elif [ $1 = 'pytorch' ]; then
        echo 'Installing PyTorch v. 0.1.7.post2 ...'
        pip3 install --upgrade https://s3.amazonaws.com/pytorch/whl/cu80/torch-0.1.7.post2-cp35-cp35m-linux_x86_64.whl
        pip3 install --upgrade torchvision
    elif [ $1 = 'help' ]; then
        echo 'Help text ::'
        echo 'This script can be used to install/upgrade selected packages.'
        echo 'The following packages can be selected:'
        echo "* 'help' - print help text"
        echo "* 'theano' - Install/upgrade to the latest version of Theano"
        echo "* 'lasagne' - Install/upgrade to the latest version of Lasagne"
        echo "* 'keras' - Install/upgrade to the latest version of Keras"
        echo "* 'ml-pyxis' - Install/upgrade to the latest version of ml-pyxis"
        echo "* 'pytorch' - Install PyTorch 0.1.7.post2"
        echo 'Invoke an upgrade by writing <script name> followed by one of the'
        echo 'strings in the list above.'
    else
        echo 'The following parameter was not recognised: ' $1
        exit 1
    fi

    echo ''
    echo 'Script completed.'
    exit 0
}

upgrade_packages $1
# END
