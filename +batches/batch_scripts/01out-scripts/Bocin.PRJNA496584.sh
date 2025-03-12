#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR19161648 SRR19161649 SRR19161650 SRR19164837 SRR19164836 SRR8074932 SRR8074933 SRR8074934 SRR8074930 SRR8074931 SRR8074936 SRR8074935 SRR8074937 SRR8074938 SRR8074939 SRR8074949 SRR8074941 SRR8074948 \
--conditions SRR19161648:Z.d1d2 SRR19161649:Z.d1d2 SRR19161650:Z.d1d2 SRR19164837:A SRR19164836:B SRR8074932:C SRR8074933:B SRR8074934:A SRR8074930:C SRR8074931:C SRR8074936:D SRR8074935:D SRR8074937:E SRR8074938:E SRR8074939:E SRR8074949:G SRR8074941:G SRR8074948:G \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


