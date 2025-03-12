
rm genome_lengths.txt
touch genome_lengths.txt

for FILE in *.f*a
do
	LENGTH=$(cat $FILE | grep -v ">" | wc -c)
	echo $LENGTH' '$FILE >> genome_lengths.txt

done