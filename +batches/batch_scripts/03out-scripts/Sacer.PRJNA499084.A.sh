#!/bin/bash

mkdir ../annotations/Sacer.PRJNA499084
cd ../annotations/Sacer.PRJNA499084

echo Sacer.PRJNA499084.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




