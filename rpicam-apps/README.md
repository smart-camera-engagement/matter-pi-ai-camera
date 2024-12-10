# rpicam-apps

Features:

- Run ObjectDetection with calling rpicam-still
- Based on human presence status, set boolean value to a shared memory.

## Remove pre-installed rpicam-apps

```bash
sudo apt remove --purge rpicam-apps
```

## Install libcamera

Reference : https://www.raspberrypi.com/documentation/computers/camera_software.html#building-libcamera

```bash
sudo apt install -y libcamera-dev libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev
```

```bash
sudo apt install -y qtbase5-dev libqt5core5a libqt5gui5 libqt5widgets5
```

```bash
sudo apt install -y libavcodec-dev libavdevice-dev libavformat-dev libswresample-dev
```

## Building rpicam-apps

Reference : https://www.raspberrypi.com/documentation/computers/camera_software.html#building-libcamera

### Install dependencies

```bash
sudo apt install -y cmake libboost-program-options-dev libdrm-dev libexif-dev
sudo apt install -y meson ninja-build
```

### Clone code

```bash
git clone https://github.com/raspberrypi/rpicam-apps.git -b v1.5.3
cd rpicam-apps
```

### Apply patch

- Copy [diff.patch](diff.patch) to \<cloned dir\>/rpicam-apps
- Apply patch

    ```bash
    git apply diff.patch
    ```

### Build rpicam-apps

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

- Update cache

    ```bash
    sudo ldconfig
    ```

- Check command

    ```bash
    rpicam-still --version
    ```

## Install imx500 package

```bash
sudo apt install -y imx500-all
```

## Run rpicam-apps

For detecting human presence, run rpicam-hello or other rpicam-apps with mobilenet ssd model.

```bash
rpicam-hello -t 0s --post-process-file /usr/share/rpi-camera-assets/imx500_mobilenet_ssd.json --viewfinder-width 1920 --viewfinder-height 1080 --framerate 30
```
