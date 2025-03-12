#!/bin/bash

mkdir ../annotations/Vedah.PRJNA198742
cd ../annotations/Vedah.PRJNA198742

echo Vedah.PRJNA198742.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




