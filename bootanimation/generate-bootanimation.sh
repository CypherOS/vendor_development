#!/bin/bash

WIDTH=$1
HEIGHT=$2
HALF_RES=$3

FPS=60

OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

# Halve image size if HALF_RES
if [ "$HALF_RES" = "true" ]
then
    WIDTH=$((WIDTH / 2))
    HEIGHT=$((HEIGHT / 2))
fi

# Decompress bootanimation.zip
unzip -q "vendor/aoscp/bootanimation/bootanimation.zip" -d "$OUT/bootanimation/"

# Resize all images
for IMAGE in "$OUT/bootanimation/"*"/"*".png"
do
    mogrify -resize "${WIDTH}x$HEIGHT" -colors 250 "$IMAGE"
done

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
