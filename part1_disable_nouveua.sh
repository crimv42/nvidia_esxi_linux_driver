#!/usr/bin/env bash

###############################################################
# This is part 1 of 3 scripts to install NVIDIA drivers to an #
# ESXi 7/8 VM. You will first need to rebuild the kernel to   #
# not use the Nouveau driver, and then enable                 #
# NVreg_OpenRmEnableUnsupportedGpus=1 in the kernel as well.  #
# This part of the script does that, then reboots to the new  #
# kernel.                                                     #
###############################################################

# Check if the script is run as sudo (EUID 0)
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root using sudo."
  exit 1
fi

# Blacklist Nouveau
blacklist_nouveau() {
  touch /etc/modprobe.d/blacklist-nvidia-nouveau.conf
  cat >>/etc/modprobe.d/blacklist-nvidia-nouveau.conf <<EOF
blacklist nouveau
options nouveau modeset=0
EOF
}

# Enabled nvdia nvreg_openrmenableupsupportedgpus
enableNVIDIA() {
  touch /etc/modprobe.d/nvidia.conf
  cat >>/etc/modprobe.d/nvidia.conf <<EOF
options nvidia NVreg_OpenRmEnableUnsupportedGpus=1
EOF
}

rebootNow() {
  read -pr "Kernel update successful. Do you want to reboot now? (y/n): " reboot_choice
  if [ "${reboot_choice}" = "y" ]; then
    echo "Rebooting the machine in 5 seconds"
    sleep 5
    sudo reboot now
  elif [ "${reboot_choice}" = "n" ]; then
    echo "Not rebooting the machine."
  else
    echo "Invalid choice. Please enter 'y' for yes or 'n' for no."
  fi
}


blacklist_nouveau
enableNVIDIA
sudo update-initramfs -u

rebootNow