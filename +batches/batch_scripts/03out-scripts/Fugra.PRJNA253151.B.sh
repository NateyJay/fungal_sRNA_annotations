#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253151
cd ../annotations/Fugra.PRJNA253151

echo Fugra.PRJNA253151.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




