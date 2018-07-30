#!/bin/bash

### Script that creates an archive and uploads it to Amazon Glacier, using glacier-cli (https://github.com/basak/glacier-cli)
### Run './backup_to_glacier.sh folder_to_archive vault'``

folder="$1"
vault="$2"

file="${folder}.tar.gz"

echo "Creating $file archive now..."
tar -cvzf $file $folder

echo "Uploading $file now..."
glacier archive upload $vault $file

echo "All done"

