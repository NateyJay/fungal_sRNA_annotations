#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




