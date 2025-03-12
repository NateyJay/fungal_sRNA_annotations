#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




