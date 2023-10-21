#!/usr/bin/env bash

###############################################################
# This is part 1 of 3 scripts to install NVIDIA drivers to an #
# ESXi 7/8 VM. You will first need to rebuild the kernel to   #
# not use the Nouveau driver, and then enable                 #
# NVreg_OpenRmEnableUnsupportedGpus=1 in the kernel as well.  #
# This part of the script does that, then reboots to the new  #
# kernel.                                                     #
###############################################################

# Blacklist Nouveau
blacklist_nouveau() {
touch /etc/modprobe.d/blacklist-nvidia-nouveau.conf
cat >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF
}

# Enabled nvdia nvreg_openrmenableupsupportedgpus
touch /etc/modprobe.d/nvidia.conf
cat >> /etc/modprobe.d/nvidia.conf << EOF
options nvidia NVreg_OpenRmEnableUnsupportedGpus=1
EOF
sudo update-initramfs -u

read -p "Kernel update successful. Do you want to reboot now? (y/n): " reboot_choice

if [ "$choice" = "y" ]; then
  echo "Rebooting the machine in 5 seconds"
  sleep 5
  sudo reboot now
elif [ "$choice" = "n" ]; then
  echo "Not rebooting the machine."
else
  echo "Invalid choice. Please enter 'y' for yes or 'n' for no."
fi
