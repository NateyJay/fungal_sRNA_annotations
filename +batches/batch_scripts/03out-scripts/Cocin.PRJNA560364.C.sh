#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




