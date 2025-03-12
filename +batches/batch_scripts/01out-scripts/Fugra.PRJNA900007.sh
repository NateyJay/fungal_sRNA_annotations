#!/bin/bash

mkdir ../annotations/Fugra.PRJNA900007
cd ../annotations/Fugra.PRJNA900007

echo Fugra.PRJNA900007


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR22252427 SRR22252441 SRR22252442 SRR22252443 SRR22252435 SRR22252436 SRR22252437 SRR22252438 SRR22252439 SRR22252440 \
--conditions SRR22252427:A SRR22252441:F SRR22252442:F SRR22252443:G SRR22252435:Z.d1d2 SRR22252436:Z.d1d2 SRR22252437:Y.d2 SRR22252438:Y.d2 SRR22252439:X.d1 SRR22252440:X.d1 \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

echo "
downloading..."
yasma.py download -o .

echo "
finding adapters..."
yasma.py adapter -o .

echo "
trimming..."
yasma.py trim -o . --cores 28

echo "
aligning..."
yasma.py align -o . --cores 28


