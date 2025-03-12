#!/bin/bash

mkdir ../annotations/Pustr.PRJNA355964
cd ../annotations/Pustr.PRJNA355964

echo Pustr.PRJNA355964.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




