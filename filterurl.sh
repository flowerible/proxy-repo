#!/bin/bash

# set the input and output filenames
input_filename=$1
output_filename="urlist"

# loop through each line in the input file
while read -r line; do
  # extract the URL from the line
  url=$(echo "$line" | awk '{print $2}')

  # check if the url ends with ".deb"
  if [[ "$url" == *.deb ]]; then
    # append the url to the output file
    echo "$url" >> "$output_filename"
  fi
done < "$input_filename"
