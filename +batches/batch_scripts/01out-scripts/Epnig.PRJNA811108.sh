#!/bin/bash

mkdir ../annotations/Epnig.PRJNA811108
cd ../annotations/Epnig.PRJNA811108

echo Epnig.PRJNA811108


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR18163558 SRR18163560 SRR18163559 \
--conditions SRR18163558:A SRR18163560:A SRR18163559:A \
--genome_file ../../Genomes/Epnig.GCA_002116315.1_ASM211631v1_genomic.fa

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


