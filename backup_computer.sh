#!/bin/bash

### Script that backups my files, from my laptop onto my external hard drive.

path_on_hard_drive="/media/etienne/Etienne/backup"

printf "### Starting file backup now...\n"

sleep 2

rsync -a --progress ~/Documents --exclude-from 'Backup-exclude-list' $path_on_hard_drive
rsync -a --progress ~/madloba-documents $path_on_hard_drive
rsync -a --progress ~/Videos $path_on_hard_drive
rsync -a --progress ~/KeePass $path_on_hard_drive
rsync -a --progress ~/travel $path_on_hard_drive
rsync -a --progress --exclude='.*' ~/tig $path_on_hard_drive
rsync -a --progress ~/vm-backup $path_on_hard_drive
rsync -a --progress ~/Music $path_on_hard_drive
rsync -a --progress ~/shared $path_on_hard_drive
rsync -a --progress ~/Pictures --exclude-from 'Backup-exclude-list' $path_on_hard_drive

printf "### All done.\n"

