# RaspberryPi + AI Camera as a Matter device (HomeKit)

This document explains how to setup RaspberryPi as Matter contact sensor device with PI AI Camera.

Current status: No AI camera integrated. Only "psuedo" contact sensor works.

## Block diagram

![Block Diagram](./resources/block_diagram.PNG.jpg)

## Tested environment

- raspberryPi 4B 4GB (Recommend 8GB)
- 64GB SD card
  - 32GB is too small. Required 64GB or more.
- RaspberryPi AI Cam
- RaspberryPi OS 64bit (latest)
- Matter SDK v1.3.0.0
- rpicam-apps v1.5.3

## Update imx500 firmware to V15 for RaspberryPi 4B (Skip it with RaspberryPi 5)

- Reference: https://forums.raspberrypi.com/viewtopic.php?t=378050

It is requred to perform firmware update for detecting AI Cam for RaspberryPi 4B. Perform these seteps without connecting PI AI camera.

1. Open config.txt file

	```bash
	sudo vi /boot/firmware/config.txt
	```

2. Find camera_auto_detect and comment out.

	```bash
	#camera_auto_detect=1
	```

3. Add this line at the bottom.

	```bash
	dtoverlay=imx500
	````

4. Power off and connect AI Camera.

5. Copy imx500_i2c_flash and main_v15.bin from https://drive.google.com/drive/folders/1aUWJt8y4i1wAmRtE28j1tbEOTYlS3gzJ?usp=drive_link

6. Flash firmware

	```bash
	chmod +x ./imx500_i2c_flash
	./imx500_i2c_flash main_v15.bin
	```

7. Check imx500 is listed as an available camera

	```bash
	rpicam-hello --list-cameras
	```

8. Check output:

	```bash
		Available cameras
		-----------------
		0 : imx500 [4056x3040 10-bit RGGB] (/base/soc/i2c0mux/i2c@1/imx500@1a)
			Modes: 'SRGGB10_CSI2P' : 2028x1520 [30.02 fps - (0, 0)/4056x3040 crop]
								4056x3040 [10.00 fps - (0, 0)/4056x3040 crop]
	```

## PI AI Cam setup

- Reference: https://www.raspberrypi.com/documentation/accessories/ai-camera.html

1. Update

	```bash
	sudo apt update && sudo apt full-upgrade
	```

2. Install imx500 package

	```bash
	sudo apt install imx500-all
	sudo reboot
	```

3. Test raspicam

	```bash
	rpicam-hello -t 0s --post-process-file /usr/share/rpi-camera-assets/imx500_mobilenet_ssd.json --viewfinder-width 1920 --viewfinder-height 1080 --framerate 30
	```

## Increase swap

ninja command consume memory. Increase swap size from 512MB to 2GB.

1. Check current swap size and open ddphys-swapfile file.

	```bash
	free
	sudo dphys-swapfile swapoff
	sudo vi /etc/dphys-swapfile
	```

2. Modify swap size to 2GB.

	- Before modification : CONF_SWAPSIZE=512
	- After modification  : CONF_SWAPSIZE=2048

3. Apply change.

	```bash
	sudo dphys-swapfile setup
	sudo dphys-swapfile swapon
	free
	```

## Setup homebridge

Refer : [README.md](./homebridge/README.md)

## Setup rpicam-apps

Refer : [README.md](./rpicam-apps/README.md)

## Setup Matter contact sensor

Refer : [README.md](./connectedhomeip//README.md)
