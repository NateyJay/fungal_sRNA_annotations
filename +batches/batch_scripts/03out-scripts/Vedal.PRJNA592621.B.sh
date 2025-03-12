#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




