#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0

if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "You must be root to run this script."
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 <log-file-name>"
  exit 2
fi

LOG_FILE=$LOG_DIR/$1

if [ ! -f $LOG_FILE ]; then
  echo "The log file $LOG_FILE does not exist."
  exit 3
fi

ROTATED_LOG=$LOG_FILE.`date +%Y%m%d`

cp $LOG_FILE $ROTATED_LOG
echo "" > $LOG_FILE

exit 0

