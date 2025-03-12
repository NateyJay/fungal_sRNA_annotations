#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA760453
cd ../annotations/Fuoxy.PRJNA760453

echo Fuoxy.PRJNA760453.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




