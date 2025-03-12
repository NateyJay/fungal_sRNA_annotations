#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




