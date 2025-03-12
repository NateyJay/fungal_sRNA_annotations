#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




