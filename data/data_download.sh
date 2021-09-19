curl -L -o "./AdventureWorks2019.bak" https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak
curl -L -o "./AdventureWorksDW2019.bak" https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2019.bak

sudo docker exec -d sql-server mkdir /var/opt/mssql/backup/
sudo docker cp ./AdventureWorks2019.bak sql-server:/var/opt/mssql/backup/
sudo docker cp ./AdventureWorksDW2019.bak sql-server:/var/opt/mssql/backup/
sudo docker cp ./restore_database.sql sql-server:/tmp/restore_database.sql
