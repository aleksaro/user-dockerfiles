#!/usr/bin/env bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Script for simplifying the act of upgrading packages that change frequently.
#

function upgrade_packages {
    echo 'Upgrading the following packages to the latest version:'

    echo 'Theano...'
    pip3 install --upgrade git+git://github.com/Theano/Theano.git@master

    echo ''
    echo 'Lasagne...'
    pip3 install --upgrade git+git://github.com/Lasagne/Lasagne.git@$master

    echo ''
    echo 'Keras...'
    pip3 install --upgrade git+git://github.com/fchollet/keras.git@$master

    echo ''
    echo 'ml-pyxis...'
    pip3 install --upgrade git+git://github.com/vicolab/ml-pyxis.git@$master

    echo ''
    echo 'Upgrading of packages has finished.'
}

upgrade_packages
# END
