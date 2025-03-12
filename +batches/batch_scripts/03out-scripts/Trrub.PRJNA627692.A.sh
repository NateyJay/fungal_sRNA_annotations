#!/bin/bash

mkdir ../annotations/Trrub.PRJNA627692
cd ../annotations/Trrub.PRJNA627692

echo Trrub.PRJNA627692.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




