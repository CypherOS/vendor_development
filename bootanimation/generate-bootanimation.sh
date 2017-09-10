#!/bin/bash

WIDTH=$1
HEIGHT=$2
HALF_RES=$3

FPS=60

OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

# Halve image size if HALF_RES
if [ "$HALF_RES" = true ]
then
    WIDTH=$((WIDTH / 2))
    HEIGHT=$((HEIGHT / 2))
fi

# Create a folder for each part
for part_cnt in 0 1 2 3
do
    mkdir -p "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt"
done

# Decompress bootanimation.zip
tar xfp "vendor/aoscp/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"

# Resize all images
mogrify -resize "${WIDTH}x${HEIGHT}>" -colors 250 "$OUT/bootanimation/"*"/"*".png"

# Create desc.txt
echo "$1 $2 $FPS" > "$OUT/bootanimation/desc.txt"
cat "vendor/aoscp/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"
zip -qr0 "$OUT/bootanimation.zip" .
