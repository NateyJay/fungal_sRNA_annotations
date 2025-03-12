#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




