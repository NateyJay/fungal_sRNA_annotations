#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




