#!/bin/bash

root_url="https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles/"

html=$(curl -s "$root_url")
pattern="$*.csv.gz$"
files=$(echo "$html" | grep -Eo 'href="[^"]+"' | cut -d'"' -f2 | grep -E "$pattern")

for file in $files; do
  # Skip if file has already been downloaded
  if [ -f `pwd`/${file} ]; then
    echo "${file} already downloaded"
    continue
  else
    echo "Downloading $file from $root_url"
    curl -O "${root_url}${file}"

    # Apply gunzip
    gunzip $file
  fi
done

