#!/bin/bash

# Define variables
log_dir="/var/log"
backup_dir="/mnt/backup"
current_date=$(date +%Y-%m-%d)

# Check if backup directory exists
if [ ! -d "$backup_dir" ]; then
  # Create backup directory if it does not exist
  sudo mkdir $backup_dir
fi

# Create a backup of log files
sudo cp $log_dir/*.log $backup_dir/log_backup_$current_date/

# Compress the log backup folder
sudo tar -czvf $backup_dir/log_backup_$current_date.tar.gz $backup_dir/log_backup_$current_date/

# Remove the log backup folder
sudo rm -rf $backup_dir/log_backup_$current_date/

# Rotate logs
sudo rm $log_dir/*.log
sudo touch $log_dir/new.log

# Change owner and group of new log file
sudo chown syslog:adm $log_dir/new.log

# Set permissions for new log file
sudo chmod 660 $log_dir/new.log

# Confirm completion of maintenance task
echo "Maintenance task complete. New log file created and previous logs backed up and rotated."

