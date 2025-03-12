#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA562097
cd ../annotations/Fuoxy.PRJNA562097

echo Fuoxy.PRJNA562097.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




