#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193535
cd ../annotations/Bocin.PRJNA193535

echo Bocin.PRJNA193535.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




