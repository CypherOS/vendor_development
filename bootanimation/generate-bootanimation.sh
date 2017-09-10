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
PARTS=$(grep . -c < "vendor/aoscp/bootanimation/desc.txt")

while [ "$PARTS" -gt 0 ]
do
    PARTS=$((PARTS-1))
    mkdir -p "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$PARTS"
done

# Decompress bootanimation.tar
tar xfp "vendor/aoscp/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"

# Resize all images
mogrify -resize "${WIDTH}x${HEIGHT}>" -colors 250 "$OUT/bootanimation/"*"/"*".png"

# Get new width and height
WIDTH=$(identify -format "%w " "$OUT/bootanimation/"*"/"*".png" | cut -d ' ' -f 1)
HEIGHT=$(identify -format "%h " "$OUT/bootanimation/"*"/"*".png" | cut -d ' ' -f 1)

# Duplicate image size if HALF_RES
if [ "$HALF_RES" = true ]
then
    WIDTH=$((WIDTH * 2))
    HEIGHT=$((HEIGHT * 2))
fi

# Create desc.txt
echo "$WIDTH $HEIGHT $FPS" > "$OUT/bootanimation/desc.txt"
cat "vendor/aoscp/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"
zip -q -r -0 "$OUT/bootanimation.zip" .
