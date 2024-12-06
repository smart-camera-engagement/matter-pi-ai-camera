
# Matter contact sensor

Features:

- Read Opened/Closed status from shared memory.
- Send Opened/Closed status to HomeKit

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
sudo apt-get install git gcc g++ pkg-config libssl-dev libdbus-1-dev \
     libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
     python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev
```

## Apply patch for contact sensor

copy [new_file.patch](./patch/new_file.patch) and [diff.patch](./patch/diff.patch) to connectedhomeip and apply patch.

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
