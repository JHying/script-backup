ROOT_PATH="/home/user/myfile/redmine"
#!/bin/bash 
echo $(date "+%Y-%m-%d %H:%M:%S") "Repo sync starts..." >> $ROOT_PATH/sync.log 
#start sync 
cd $ROOT_PATH/git/puhui/puhui.git && git fetch --all
#write log file 
echo $(date "+%Y-%m-%d %H:%M:%S") "Repo sync finished." >> $ROOT_PATH/sync.log 

