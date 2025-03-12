#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




