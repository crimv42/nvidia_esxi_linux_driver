#!/usr/bin/env bash

############################################################
#  This is part 2 of NVIDIA driver install on ESXi VM      #
#  using PCI Passthrough. This part will ensure the driver #
#  is installed. Make sure to set the driver link to the   #
#  version you want to use.                                #
############################################################

# Check if the script is run as sudo (EUID 0)
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root using sudo."
  exit 1
fi

# Set Driver Variables
DRIVER="https://us.download.nvidia.com/XFree86/Linux-x86_64/535.113.01/NVIDIA-Linux-x86_64-535.113.01.run"
FILE=$(echo "${DRIVER}" | sed 's/.*\///')
FILEPATH="/tmp/"


install_driver() {
  wget -O ${FILEPATH}/${FILE} ${DRIVER}
  sudo chmod u+x ${FILEPATH}/${FILE}
  sudo apt install build-essential gcc make
  sudo apt install pkg-config libglvnd-dev
  sudo bash ${FILEPATH}/${FILE} -m=kernel-open
}

echo "Going to install driver: ${FILE}"
sleep 5

install_driver
