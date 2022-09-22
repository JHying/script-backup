#!/bin/bash

#Backup GitLab Container Data
docker exec -it gitlab gitlab-rake gitlab:backup:create
#Clean old files
rm -rf /media/user/新增磁碟區/gitlab_bak/*
echo "GitLab backup folder clean, bak file copy starts..."
#Copy file to host
docker cp gitlab:/var/opt/gitlab/backups/. /media/user/新增磁碟區/gitlab_bak
docker cp gitlab:/etc/gitlab/gitlab-secrets.json /media/user/新增磁碟區/gitlab_bak
docker cp gitlab:/etc/gitlab/gitlab.rb /media/user/新增磁碟區/gitlab_bak
echo "GitLab backup copy finished."
#write log file
echo "$(date "+%Y-%m-%d %H:%M:%S") gitlab backup finished." >> /media/user/新增磁碟區/log/gitlab_bak.log
