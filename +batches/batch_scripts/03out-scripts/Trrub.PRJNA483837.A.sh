#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




