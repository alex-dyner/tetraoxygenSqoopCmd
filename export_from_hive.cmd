
host=localhost
schema_name=dds_via_sqoop
target_database_url=jdbc:mysql://${host}:3306/${schema_name}


mysql_username=developer
mysql_password=dev_password
number_of_mappers=2
field_sep=,

while read -r tablename; do

mysql --protocol=TCP --host=${host} --user=${mysql_username} --password=${mysql_password} -e "TRUNCATE TABLE ${schema_name}.${tablename};"

source_data_path=/user/adyner/dds/${tablename}

sqoop export \
--connect ${target_database_url} \
--table ${tablename} \
--export-dir ${source_data_path} \
--password ${mysql_password} \
--username ${mysql_username} \
--export-dir ${source_data_path} \
-m ${number_of_mappers} \
--input-fields-terminated-by ${field_sep}

done < tables_to_export.list

#while read -r tablename; do
#mysql --protocol=TCP --host=${host} --user=${mysql_username} --password=${mysql_password} -e "SELECT count(*) FROM ${schema_name}.${tablename};"
#done < tables_to_export.list



