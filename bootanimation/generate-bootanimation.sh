#!/bin/bash

WIDTH=$1
HEIGHT=$2
HALF_RES=$3

OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

# Check if sizes are upside down
if [[ $WIDTH -lt $HEIGHT ]]
then
    WIDTH=$HEIGHT
fi

# Get the original size to put in the desc.txt
if [[ $HALF_RES == true ]]
then
    convert "$(find ./*/*.png | head -n 1)" -resize "$WIDTH" test.png

    IMAGESCALEWIDTH=$(identify -format "%w" test.png)
    IMAGESCALEHEIGHT=$(identify -format "%h" test.png)

    rm -rf test.png

    WIDTH=$((WIDTH / 2))
fi

# Create a folder for each part
for part_cnt in 0 1 2 3 4
do
    mkdir -p "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt"
done

# Extract the images
tar xfp "vendor/aoscp/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"

# Resize the images
mogrify -resize "$WIDTH" -colors 250 "$OUT/bootanimation/"*"/"*".png"

# Get the new image size if unset
if [[ -z $IMAGESCALEWIDTH || -z $IMAGESCALEHEIGHT ]]
then
    IMAGESCALEWIDTH=$(identify -format "%w" "$(find ./*/*.png | head -n 1)")
    IMAGESCALEHEIGHT=$(identify -format "%h" "$(find ./*/*.png | head -n 1)")
fi

# Create desc.txt
echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT" 60 > "$OUT/bootanimation/desc.txt"
cat "vendor/aoscp/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"
zip -qr0 "$OUT/bootanimation.zip" .
