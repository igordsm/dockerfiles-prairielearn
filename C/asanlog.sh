#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: You must provide the path to an executable."
  echo "Usage: $0 <path_to_executable> [optional arguments for executable...]"
  exit 1
fi

LOG_DIR="/home/coder/.asan_logs"
mkdir -p "$LOG_DIR"

RUN_ID=$(date +"%Y%m%d_%H%M%S")
export LOG_FILE_PREFIX="${LOG_DIR}/report_${RUN_ID}.log" 
echo "Run ID: $RUN_ID"
ASAN_OPTIONS="log_path=${LOG_FILE_PREFIX}:continue_on_error=1" ASANLOG_ENABLED="true" "$@"
rm -f /home/coder/project/asanlogs.zip
zip -r --junk-paths /home/coder/project/asanlogs.zip /home/coder/.asan_logs > /dev/null 2>&1 || true