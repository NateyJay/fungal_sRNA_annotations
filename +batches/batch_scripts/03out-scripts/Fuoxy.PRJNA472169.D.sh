#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




