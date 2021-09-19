USE [master] 
RESTORE DATABASE [AdventureWorks2019] 
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2019.bak' 
WITH MOVE 'AdventureWorks2017' to '/var/opt/mssql/data/AdventureWorks2019.mdf', 
MOVE 'AdventureWorks2017_Log' to '/var/opt/mssql/data/AdventureWorks2019_log.ldf', 
NOUNLOAD, STATS = 5

USE [master] 
RESTORE DATABASE [AdventureWorksDW2019] 
FROM DISK = "/var/opt/mssql/backup/AdventureWorksDW2019.bak" 
WITH MOVE "AdventureWorksDW2017" to "/var/opt/mssql/data/AdventureWorksDW2019.mdf", 
MOVE "AdventureWorksDW2017_Log" to "/var/opt/mssql/data/AdventureWorksDW2019_log.ldf",
NOUNLOAD, STATS = 5
