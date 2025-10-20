#!/bin/sh

echo "Copying files to workspace folder"

cp /home/coder/template/Makefile /home/coder/project
mkdir -p /home/coder/project/.vscode/
cp /home/coder/template/tasks.json /home/coder/project/.vscode/
cp /home/coder/template/settings.json /home/coder/project/.vscode/

touch /home/coder/project/.asanlogs.zip
