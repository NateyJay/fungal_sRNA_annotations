#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




