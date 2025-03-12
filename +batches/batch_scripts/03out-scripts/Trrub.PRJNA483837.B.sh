#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




