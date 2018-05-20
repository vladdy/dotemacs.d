#!/bin/bash

set -eux

CONFDIR=$(dirname "$0")

ln -s "$CONFDIR" $HOME/.emacs.d

mkdir -p "$CONFDIR"/elpa
