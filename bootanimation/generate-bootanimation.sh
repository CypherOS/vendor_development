#!/bin/bash

WIDTH=$1
HEIGHT=$2
HALF_RES=$3

FPS=60

OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation"

# Reduce image size by 50% if HALF_RES
if [ "$HALF_RES" = true ]
then
    WIDTH=$(("$WIDTH" / 2))
    HEIGHT=$(("$HEIGHT" / 2))
fi

# Decompress bootanimation.zip
unzip -q vendor/aoscp/bootanimation/bootanimation.zip -d "$OUT"

# Resize all images
mogrify -resize "${WIDTH}x$HEIGHT" -colors 250 "$OUT/"*"/"*".png"

# Get width and height of all the images
WIDTH=$(identify -ping -format '%w ' "$OUT/"*"/"*".png" | cut -d ' ' -f 1)
HEIGHT=$(identify -ping -format '%h ' "$OUT/"*"/"*".png" | cut -d ' ' -f 1)

# Restore size to include it in desc.txt if HALF_RES
if [ "$HALF_RES" = true ]
then
    WIDTH=$(("$WIDTH" * 2))
    HEIGHT=$(("$HEIGHT" * 2))
fi

# Create desc.txt
echo "$WIDTH $HEIGHT $FPS" > "$OUT/desc.txt"
cat vendor/aoscp/bootanimation/desc.txt >> "$OUT/desc.txt"

# Create bootanimation.zip
cd "$OUT"
zip -q -r -0 ../bootanimation.zip .

