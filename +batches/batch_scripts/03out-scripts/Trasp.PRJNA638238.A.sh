#!/bin/bash

mkdir ../annotations/Trasp.PRJNA638238
cd ../annotations/Trasp.PRJNA638238

echo Trasp.PRJNA638238.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




