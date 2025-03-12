#!/bin/bash

mkdir ../annotations/Pabra.PRJNA931606
cd ../annotations/Pabra.PRJNA931606

echo Pabra.PRJNA931606.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




