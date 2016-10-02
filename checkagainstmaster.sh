#!/bin/bash
#author  kmscheuer

export IFS=$'\n'

./sortlines.sh lang.master.csv
./sortlines.sh "$1"

echo
echo "------------------------"
echo " Fehlende Übersetzungen"
echo "------------------------"

for I in `cat lang.master.csv`; do
	if [ $(grep "^$I\;" "$1" | wc -l) -ne 1 ]; then
		echo "$I"
	fi
done
echo

echo
echo "---------------------"
echo " Fehlende Semikolons"
echo "---------------------"

for I in `cat "$1"`; do
	if [ $(echo "$I" | grep ";" | wc -l) -eq 0 ]; then
		echo "$I"
	fi
done
echo


echo
echo "-----------------------------------"
echo " Semikolon gefolgt von Leerzeichen"
echo "-----------------------------------"

for I in `cat "$1"`; do
        if [ $(echo "$I" | grep "; " | wc -l) -ne 0 ]; then
                echo "$I"
        fi
done
echo


echo
echo "----------------"
echo " Enthält Ziffern"
echo "----------------"

for I in `cat "$1"`; do
        if [ $(echo "$I" | grep -e '[[:digit:]]' | grep -v " "| wc -l) -ne 0 ]; then
                echo "$I"
        fi
done
echo


echo
echo "---------------------"
echo " Überflüssige Zeilen"
echo "--------------------"

for I in `cat "$1"`; do
	KEY=`echo "$I" | cut -f 1 -d ";"`
        if [ $(grep "^$KEY$" lang.master.csv | wc -l) -ne 1 ]; then
                echo $I
        fi
done
echo


echo
echo "-----------------"
echo " Fehlende Punkte"
echo "-----------------"

for I in `cat "$1"`; do
        if [ $(echo "$I" | grep "\.;" | wc -l) -eq 1 ] && [ $(echo "$I" | tr -d '\r' | tr -d '\n' | grep "\.$" | wc -l) -eq 0 ]; then
                echo $I
        fi
done
echo


echo
echo "--------------"
echo " Punkte zuviel"
echo "--------------"

for I in `cat "$1"`; do
        if [ $(echo "$I" | grep "\.;" | wc -l) -eq 0 ] && [ $(echo "$I" | tr -d '\r' | tr -d '\n' | grep "\.$" | wc -l) -eq 1 ] && [ $(echo "$I" | grep "\.\.\." | wc -l) -eq 0 ]; then
                echo $I
        fi
done
echo
