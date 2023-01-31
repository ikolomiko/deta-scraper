#!/usr/bin/env bash

# Constants
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Variables
list="appids.txt"
until=200
i=0

mkdir -p apks

# Main loop
for line in $(cat $list); do
  # if (i >= until) break;
  [[ $i -ge $until ]] && break
  
  # i+=1
  ((i=i+1))
  
  # if (file.exists) continue
  [[ -f apks/$line.apk ]] && echo "${GREEN}$line is already downloaded${NC}" && continue
  
  echo -e "${GREEN}Downloading $i $line${NC}"
  
  # try download; except echo error $line
  wget -q https://apks.deta.dev/$line -O apks/$line.apk || echo "Error $line" | tee -a notfound.txt
done

echo -e "${RED}Finished downloading $i APKs${NC}"
