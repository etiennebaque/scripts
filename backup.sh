#!/bin/bash

### Script that backups my files, from my laptop onto server
### Run './backup.sh' (http://unix.stackexchange.com/a/253900)

destination="user@host:~/backup"

sources=("~/Documents" "~/Videos" "~/codes" "~/shared" "~/Pictures" "~/Music")

for i in "${sources[@]}"
do
  cmd="rsync -avz --progress $i $destination"
  eval $cmd
done

