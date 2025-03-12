#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




