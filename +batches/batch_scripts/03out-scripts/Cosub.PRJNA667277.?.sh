#!/bin/bash

mkdir ../annotations/Cosub.PRJNA667277
cd ../annotations/Cosub.PRJNA667277

echo Cosub.PRJNA667277.?


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n ? -a tradeoff_?


echo "
"




