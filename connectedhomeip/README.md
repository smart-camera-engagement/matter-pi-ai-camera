
# Matter contact sensor

Features:

- Read Opened/Closed status from shared memory.
- Send Opened/Closed status to HomeKit

## Increase swap

ninja build command consume memory. Increase swap size from 512MB to 2GB.

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

## Clone source

- Reference: https://github.com/project-chip/connectedhomeip/blob/v1.3.0.0/docs/guides/BUILDING.md

```bash
git clone --recurse-submodules https://github.com/project-chip/connectedhomeip.git -b v1.3.0.0
cd connectedhomeip
git submodule update --init
```

## Install dependencies

- Reference: https://github.com/project-chip/connectedhomeip/blob/v1.3.0.0/docs/guides/BUILDING.md

```bash
sudo apt-get install -y git gcc g++ pkg-config libssl-dev libdbus-1-dev \
     libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
     python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev
```

## Apply patch for contact sensor

copy [diff.patch](./diff.patch) to connectedhomeip directory and apply patch.

```bash
cd connectedhomeip
git apply diff.patch
```

## Environment setup

```bash
source ./scripts/bootstrap.sh
source ./scripts/activate.sh
```

The activate.sh is required for activating shell build environment when boot-up raspberrypi board.

## Build for contact sensor app

```bash
cd examples/contact-sensor-app/linux
gn gen out/debug
ninja -C out/debug -j3
```

## Run contact sensor app

Using wifi. (I haven't tried BLE because it require BLE-USB dongle)

```bash
./out/debug/contact-sensor-app --wifi
```

## HomeKit app

1. Open HomeKit app.
2. Click "+" on top right corner.
3. Select "Add Accessory"
4. Select "More options" if no Matter device is detected.
5. Set code "2020-2021"
6. If the process went through, device is registered as "Contact Sensor"
