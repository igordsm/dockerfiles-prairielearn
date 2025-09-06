#!/bin/sh

if [ -z "$1" ]; then
  echo "Error: You must provide the path to an executable."
  echo "Usage: $0 <path_to_executable> [optional arguments for executable...]"
  exit 1
fi

LOG_DIR="/home/coder/.asan_logs"
mkdir -p "$LOG_DIR"

RUN_ID=$(date +"%Y%m%d_%H%M%S")
LOG_FILE_PREFIX="${LOG_DIR}/report_${RUN_ID}.log"
export ASAN_OPTIONS="log_path=${LOG_FILE_PREFIX}"
echo "Run ID: $RUN_ID"
"$@"