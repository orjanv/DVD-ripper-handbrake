#!/bin/bash

INPUT_DEV=/dev/sr0
OUTPUT_FOLDER=`pwd`
PRESET="High Profile"
LSDVDOUTPUT=$(lsdvd "$INPUT_DEV")

if [ "$1" ]; then
    TITLE=$1
else
    TITLE=$(echo "$LSDVDOUTPUT" | grep -i Disc | sed 's/Disc Title: //g')
fi

LONGEST_TITLE=$(echo "$LSDVDOUTPUT" | sed '$!d' | sed 's/.*\(..\)/\1/')
echo "We will rip main feature: $TITLE from $INPUT_DEV to $OUTPUT_FOLDER using $PRESET"
HandBrakeCLI -t $LONGEST_TITLE -i $INPUT_DEV -a "1,2,3,4,5,6" -s "1,2,3,4,5,6,7,8,9" -o "$TITLE".m4v --preset "$PRESET" > hb.log 2>&1
eject $INPUT_DEV
