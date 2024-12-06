# Setup homebridge for FFmpeg

homebridge and FFmpeg for sending still image to HomeKit.

## Install homebridge

```bash
sudo apt update
sudo apt upgrade -y
```

```bash
sudo apt-get install homebridge
```

## Setup FFmpeg and check Homebridge

1. Open browser and connect homebridge.

    ```bash
    http://<Raspberry Pi IP address>:8581
    ```

2. Install Homebridge Camera FFmpeg

    - Select Plugins.
    - Search "camera-ffmpeg" and install.
    - Set JSON config like following:
      - Sample : [config.json](./Camera-ffmpeg/config.json)

        ```bash
        "name": "Camera FFmpeg",
        "cameras": [
            {
                "name": "PI AI Camera",
                "videoConfig": {
                    "source": "-re -loop 1 -i /home/homebridge/images/latest.jpg",
                    "stillImageSource": "-i /home/homebridge/images/latest.jpg",
                    "maxStreams": 2,
                    "maxWidth": 1920,
                    "maxHeight": 1080,
                    "maxFPS": 1
                }
            }
        ],
        "platform": "Camera-ffmpeg"
        ```

3. Restart homebridge and check log if there is no error.
