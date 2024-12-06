# rpicam-apps

Features:

- Run ObjectDetection with calling rpicam-still
- When human presence, set boolean value to a shared memory.
- Update jpg image for sending the latest image to HomeKit via homebridge.

## Clone code

```bash
git clone https://github.com/raspberrypi/rpicam-apps.git -b v1.5.3
cd rpicam-apps
```

## Apply patch

- Copy [diff.patch](diff.patch) to <cloned dir>
- Apply patch

    ```bash
    git apply diff.patch
    ```

## Build

- Setup

    ```bash
    meson setup build -Denable_libav=enabled -Denable_drm=enabled -Denable_egl=enabled -Denable_qt=enabled -Denable_opencv=disabled -Denable_tflite=disabled -Denable_hailo=disabled -Denable_imx500=true
    ```

- Build

    ```bash
    meson compile -C build
    ```

- Install

    ```bash
    sudo meson install -C build
    ```

## Run script

It seems that homebridge plugins can't access to /home/pi directory because homebridge is run as **homebridge** user. In order to send latest image to HomeKit, the script run in /home/homebridge directory. Here are steps.

- Create required directories

    ```bash
    sudo mkdir /home/homebridge/images
    sudo mkdir /home/homebridge/images/timelapse
    cd /home/homebridge/images
    ```

- Copy [start_human_detection.sh](./start_human_detection.sh) to /home/homebridge/images.

- Run script

    ```bash
    sudo ./start_human_detection.sh 
    ```
