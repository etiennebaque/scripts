#!/bin/bash

### Script that uploads archives to Amazon Glacier.
### Using amazon-cli as a wrapper for glacier command (https://github.com/basak/glacier-cli)
### Run './backup_to_glacier.sh folder_to_archive vault' (http://unix.stackexchange.com/a/253900)

folder="$1"
vault="$2"

echo "Spliting folder"
tar -cvzf - $folder | split -b 200M - "$vault_$folder.tar.gz."

echo "Uploading archived splits"

for f in "$vault_$1.tar.gz.*"
do
  echo "Uploading $f to $vault..."
  glacier archive upload $vault $f
  echo "Upload of $f done"
done

echo "All done"

