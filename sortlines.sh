#!/bin/bash
#author  kmscheuer

cat "$1" | LC_COLLATE=C sort > tmp.csv
mv tmp.csv "$1"
