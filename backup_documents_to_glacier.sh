#!/bin/bash

### Script that deleted backup of documents on Amazon Glacier before uploading a fresh version of this folder.
### Using amazon-cli as a wrapper for glacier command (https://github.com/basak/glacier-cli)
### Run './backup_documents.sh' (http://unix.stackexchange.com/a/253900)

vault="etienne_documents"
file_split_name="documents.tar.gz."

echo "Deleting remote archives"
for x in "$(glacier archive list $vault)"; do
  echo "Deleting $x..."
  glacier archive delete $vault $x
done

echo "Spliting document folder"
tar -cvzf - Documents | split -b 200M - $file_split_name

echo "Uploading new archived splits"

for f in "$file_split_name*"
do
  echo "Uploading $f to $vault..."
  glacier archive upload $vault $f
  echo "Upload of $f done"
done

echo "All done"

