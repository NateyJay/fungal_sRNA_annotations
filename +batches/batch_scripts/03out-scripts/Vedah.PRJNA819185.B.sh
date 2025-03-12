#!/bin/bash

mkdir ../annotations/Vedah.PRJNA819185
cd ../annotations/Vedah.PRJNA819185

echo Vedah.PRJNA819185.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




