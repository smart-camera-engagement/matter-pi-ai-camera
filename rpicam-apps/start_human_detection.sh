#!/bin/bash


IMAGE_DIR="/home/homebridge/images"

LATEST_LINK="latest.jpg"

INTERVAL=1

rm -rf $IMAGE_DIR/timelapse/*.jpg

rpicam-still --timeout 30000000 --timelapse 1000 -o timelapse/image%06d.jpg  --post-process-file /usr/share/rpi-camera-assets/imx500_mobilenet_ssd.json --width 1920 --height 1080 &

while true; do
	latest_file=$(ls "$IMAGE_DIR/timelapse" | sort -V | tail -n 1)

	if [ -n "$latest_file" ]; then
		ln -sf "$IMAGE_DIR/timelapse/$latest_file" "$IMAGE_DIR/$LATEST_LINK"
		echo "Updated $LATEST_LINK to point to $latest_file"
	else
		echo "No JPEG files found in $IMAGE_DIR/timelapse"
	fi

	find "$IMAGE_DIR/timelapse" -name "*.jpg" ! -name "$latest_file" -exec rm -f {} \;

	sleep $INTERVAL
done

 
