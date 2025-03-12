#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




