#!/bin/bash

# set the filename to a hardcoded value
output_file_url=urlist
rm Packages
touch Packages
output_file=Packages

# loop through each line in the file
while read -r url; do
  # extract the filename from the URL
  file=$(echo "$url" | awk -F/ '{print $NF}')

  # download the file using curl and pipe it to dpkg-deb
  control=$(curl -L "$url" | dpkg-deb -I /dev/stdin control)

  # Calculate checksums
  sha1=$(curl -L "$url" | shasum -a 1 | cut -d ' ' -f 1)
  sha256=$(curl -L "$url" | shasum -a 256 | cut -d ' ' -f 1)
  
  # print the result
  echo "$control" >> "$output_file"
  echo "SHA1: $sha1" >> "$output_file"
  echo "SHA256: $sha256" >> "$output_file"
  echo "Filename: $url" >> "$output_file"
  echo "" >> "$output_file"

  # continue to the next line
  continue
done < "$output_file_url"
