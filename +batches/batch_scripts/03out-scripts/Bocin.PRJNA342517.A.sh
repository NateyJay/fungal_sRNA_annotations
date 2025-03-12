#!/bin/bash

mkdir ../annotations/Bocin.PRJNA342517
cd ../annotations/Bocin.PRJNA342517

echo Bocin.PRJNA342517.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




