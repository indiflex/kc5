#!/bin/bash
docker-compose up -d
sleep 2

mysql -uroot -pTestdbRoot -h 127.0.0.1 -P 3308 -e "SET GLOBAL innodb_optimize_fulltext_only = ON;"
mysql -uroot -pTestdbRoot -h 127.0.0.1 -P 3308 -e "optimize table testdb.Notice;"
mysql -uroot -pTestdbRoot -h 127.0.0.1 -P 3308 -e "SET GLOBAL innodb_optimize_fulltext_only = OFF;"
mysql -uroot -pTestdbRoot -h 127.0.0.1 -P 3308 -e "set global innodb_ft_aux_table='testdb/Notice';"

