#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




