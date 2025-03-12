#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




