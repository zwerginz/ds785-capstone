# ds785-capstone
This repository houses code surrounding my data science capstone project. It will house infrastructure scripts, SQL queries, and data model information.

Deployment instructions:

cd /infrastructure
sudo docker-compose up -d

cd ../data
sh data_download.sh
sudo docker exec -it sql-server /bin/bash
cd /tmp
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./restore_database.sql
