#!/bin/sh
dos2unix ../config.ini
while read line;
do
    eval "$line"
done < ../config.ini
echo passwd$MYSQL_PASSWD
echo host$MYSQL_HOST
echo dbname$MYSQL_DBNAME
execDate=`date "+%Y%m%d%H%M%S"`
mysqldump -u$MYSQL_USERNAME -p$MYSQL_PASSWD $MYSQL_DBNAME -h$MYSQL_HOST > $CONTEXT_PATH/db/bak/${MYSQL_DBNAME}_${execDate}
mysql -h$MYSQL_HOST -u${MYSQL_USERNAME} -p${MYSQL_PASSWD}<<EOF
use $MYSQL_DBNAME;
source $CONTEXT_PATH/db/install.sql
EOF
#echo $sql
