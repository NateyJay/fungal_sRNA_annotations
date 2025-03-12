#!/bin/bash

mkdir ../annotations/Caalb.PRJNA317629
cd ../annotations/Caalb.PRJNA317629

echo Caalb.PRJNA317629.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




