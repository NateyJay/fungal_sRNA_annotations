#!/bin/bash

mkdir ../annotations/Scscl.PRJNA746614
cd ../annotations/Scscl.PRJNA746614

echo Scscl.PRJNA746614.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




