#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




