username=$1
passwd=$2
host=$3
`mysql -u$username -p$passwd -h $host -e"source ./new_crawler_db.sql"`
