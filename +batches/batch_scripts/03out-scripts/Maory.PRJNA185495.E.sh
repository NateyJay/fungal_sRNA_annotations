#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




