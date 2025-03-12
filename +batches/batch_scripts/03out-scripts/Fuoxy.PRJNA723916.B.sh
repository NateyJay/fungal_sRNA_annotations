#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA723916
cd ../annotations/Fuoxy.PRJNA723916

echo Fuoxy.PRJNA723916.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




