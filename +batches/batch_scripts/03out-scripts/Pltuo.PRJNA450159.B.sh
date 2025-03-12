#!/bin/bash

mkdir ../annotations/Pltuo.PRJNA450159
cd ../annotations/Pltuo.PRJNA450159

echo Pltuo.PRJNA450159.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




