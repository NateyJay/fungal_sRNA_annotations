#!/bin/bash

mkdir ../annotations/Caalb.PRJNA715092
cd ../annotations/Caalb.PRJNA715092

echo Caalb.PRJNA715092.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




