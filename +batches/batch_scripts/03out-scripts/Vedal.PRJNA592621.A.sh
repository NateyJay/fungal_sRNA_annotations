#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




