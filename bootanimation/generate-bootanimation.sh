#!/bin/bash

WIDTH="$1"
HEIGHT="$2"
HALF_RES="$3"

ORIGINAL_WIDTH="1440"
ORIGINAL_HEIGHT="1440"

OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

#Set IMAGEWIDTH as the longer of the measurements
if [ "$HEIGHT" -lt "$WIDTH" ]
then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

#Calculate aspect ratio of original image
ASPECTRATIO=$(expr $ORIGINAL_WIDTH / $ORIGINAL_HEIGHT)

#Set IMAGESCALEWIDTH and IMAGESCALEHEIGHT
IMAGESCALEWIDTH="$IMAGEWIDTH"
IMAGESCALEHEIGHT=$(expr $IMAGESCALEWIDTH / $ASPECTRATIO)

#Check if HALF_RES
if [ "$HALF_RES" = "true" ]
then
    IMAGEWIDTH=$(expr $IMAGEWIDTH / 2)
fi

#Set IMAGEHEIGHT
IMAGEHEIGHT=$(expr $IMAGEWIDTH / $ASPECTRATIO)

#Set image size
RESOLUTION=""$IMAGEWIDTH"x"$IMAGEHEIGHT""

#Create a folder for each part
for part_cnt in 0 1
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt
done

#Decompress bootanimation.zip
unzip "vendor/aoscp/bootanimation/bootanimation.zip" -d "$OUT/bootanimation/"

#Resize all images
convert -resize $RESOLUTION -colors 250 "$OUT/bootanimation/"*"/"*".png"

# Create desc.txt
echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT" 60 > "$OUT/bootanimation/desc.txt"
cat "vendor/aoscp/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"
zip -qr0 "$OUT/bootanimation.zip" .

