ROOT_PATH="/home/user/myfile/gitLab"
#!/bin/bash 
#Backup GitLab Container Data 
echo $(date "+%Y-%m-%d %H:%M:%S") "GitLab backup starts..." >> $ROOT_PATH/backup.log 
docker exec gitlab gitlab-rake gitlab:backup:create 
#clean old files 
rm -rf $ROOT_PATH/backup/* 
#copy file to host 
docker cp gitlab:/var/opt/gitlab/backups/. $ROOT_PATH/backup
docker cp gitlab:/etc/gitlab/gitlab-secrets.json $ROOT_PATH/backup
docker cp gitlab:/etc/gitlab/gitlab.rb $ROOT_PATH/backup
#write log file 
echo $(date "+%Y-%m-%d %H:%M:%S") "GitLab backup finished." >> $ROOT_PATH/backup.log 