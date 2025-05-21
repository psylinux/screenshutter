#!/bin/bash

# FIRST: Install the required softwares
# brew install ghostscript img2pdf cliclick

# Configuration
PAGES=100
DIR=~/Desktop/Screenshots_new
DELAY=2

# Set your capture region: R{x},{y},{width},{height}
REGION="600,47,720,1020" # Adjust for your PDF view

mkdir -p "$DIR"

sleep 10
for i in $(seq -w 1 $PAGES); do
  echo "Capturing page $i..."
  screencapture -R$REGION "$DIR/page_$i.png"
  sleep $DELAY
  cliclick kp:enter kp:arrow-right
done

# Merging pictures into PDF file
img2pdf $DIR/*.png -o $DIR/../FullBook.pdf

# Compressing the PDF file
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile=$DIR/../FullBook_compressed.pdf \
   $DIR/../FullBook.pdf

echo "✅ All done! Screenshots saved to $DIR"
