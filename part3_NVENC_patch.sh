#!/usr/bin/env bash

########################################################
# This step is optional.                               #
# This patch removes restriction on maximum            #
# number of simultaneous NVENC video encoding sessions #    
# imposed by Nvidia to consumer-grade GPUs.            #
# https://github.com/keylase/nvidia-patch              #
########################################################

# Patch Driver
wget -O /tmp/patch.sh https://raw.githubusercontent.com/keylase/nvidia-patch/master/patch.sh
chmod +x /tmp/patch.sh
bash /tmp/patch.sh

