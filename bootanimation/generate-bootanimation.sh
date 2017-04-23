#!/bin/bash

SIZE="$1"
HALF_RES="$2"
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

#Check if HALF_RES
if [ "$HALF_RES" = "true" ]
then
    SIZE=$(expr $SIZE / 2)
fi

#Define image size
RESOLUTION=""$SIZE"x"$SIZE""

#Create a folder for each part
for part_cnt in 0 1
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt
done

#Decompress bootanimation.zip
unzip "vendor/aoscp/bootanimation/bootanimation.zip" -d "$OUT/bootanimation/"

#Resize all images
mogrify -resize $RESOLUTION -colors 250 "$OUT/bootanimation/"*"/"*".png"

# Create desc.txt
echo "$SIZE $SIZE" 60 > "$OUT/bootanimation/desc.txt"
cat "vendor/aoscp/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"
zip -qr0 "$OUT/bootanimation.zip" .

