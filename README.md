# VMware ESXi Nvidia Passthrough driver install script

While trying to enabled PCI passthrough on my GTX 1650, I was having trouble in linux until a reddit user pointed me to this thread

https://forums.developer.nvidia.com/t/nvidia-smi-no-devices-were-found-vmware-esxi-ubuntu-server-20-04-03-with-rtx3070/202904/40

There I found the steps needed to make the driver work properly, and have decied to make a script to do this work for us. 

I hope this helps someone else fighting this issue in the future

## Install

### Step 1
First run the script `part1_disable_nouveua.sh` to disable nouveua drivers as the Nvidia driver does not like it. This wil also enable `NVreg_OpenRmEnableUnsupportedGpus=1` option for the kernel. Once this script is ran, you will need to reboot to load the new kernel updates

### Step 2
Now that the new kernel is loaded, run `part2_driver_install.sh` to install the Nvidia driver with the proper options to make it work with passthrough. You may want to change the variable `DRIVER` in this file to the driver URL you want to install. This will also install the needed dependencies for the driver.

### Step 3 (Optional)
This script is completely optional and will only patch the driver to remove NVENC limits on consumer GPUs.