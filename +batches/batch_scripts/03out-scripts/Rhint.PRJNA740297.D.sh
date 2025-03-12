#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




