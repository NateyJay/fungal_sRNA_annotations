#!/bin/bash

mkdir ../annotations/Asfum.PRJNA317629
cd ../annotations/Asfum.PRJNA317629

echo Asfum.PRJNA317629.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




