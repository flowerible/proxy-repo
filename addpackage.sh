#!/bin/bash

output_file=Packages
output_file_url=urlist
url=$1

# Extract the file name from the URL
file=$(basename "$url")

# Download the file using curl, and extract
control=$(curl -L "$url" | dpkg-deb -I /dev/stdin control)

# Calculate checksums
md5=$(md5sum "$file" | awk '{print $4}')
sha1=$(shasum -a 1 "$file" | cut -d ' ' -f 1)
sha256=$(shasum -a 256 "$file" | cut -d ' ' -f 1)

# echo into output file
echo "$control" >> $output_file
echo "SHA1: $sha1" >> $output_file
echo "SHA256: $sha256" >> $output_file
echo "Filename: $url" >> $output_file
echo "" >> $output_file
sleep 1
echo "$url" >> $output_file_url
