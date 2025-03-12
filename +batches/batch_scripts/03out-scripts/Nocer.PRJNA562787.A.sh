#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




