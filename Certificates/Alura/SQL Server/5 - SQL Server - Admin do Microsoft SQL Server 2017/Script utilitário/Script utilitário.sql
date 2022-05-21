USE SUCOS_VENDAS
GO

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

SELECT @@VERSION AS 'SQL Server Version'
GO

SELECT @@SERVICENAME
GO

SELECT @@SERVERNAME
GO

SELECT @@CONNECTIONS
GO

SELECT * FROM SYS.database_files
GO

SELECT * FROM .SYS.databases
GO

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x

-- CRIAÇÃO DE DATABASE

USE SUCOS_VENDAS
SELECT * FROM SYS.DATABASE_FILES
GO

CREATE DATABASE newDB
GO

USE newDB
SELECT * FROM SYS.DATABASE_FILES
GO

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- CRIAÇÃO DE DATABASE COM CRITÉRIOS.

-- Criação de banco de dados com critérios.

CREATE DATABASE ARCHIVE
ON PRIMARY 
(NAME = ARCH1, FILENAME = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\archive1.mdf', SIZE = 100MB, MAXSIZE = 200MB, FILEGROWTH = 20MB)
,
(NAME = ARCH2, FILENAME = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\archive2.mdf', SIZE = 100MB, MAXSIZE = 200MB, FILEGROWTH = 20MB)
LOG ON
(NAME = ARCH1LOG, FILENAME = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\archive1log.mdf', SIZE = 100MB, MAXSIZE = 200MB, FILEGROWTH = 20MB)

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- DESCONECTAR/INDISPONIBILIZAR BANCO DE DADOS PARA USUÁRIOS.

USE SUCOS_VENDAS

-- Desconetar banco de dados para nenhum usuário entrar. Deixa o banco de dados indisponível.
ALTER DATABASE SUCOS_VENDAS SET RECOVERY SIMPLE

-- Reduzir o tamanho do banco de dados.
DBCC SHRINKDATABASE ('SUCOS_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('SUCOS_VENDAS', TRUNCATEONLY)

-- Conectar banco de dados para usuário entrar. Deixa o banco de dados disponível.
ALTER DATABASE SUCOS_VENDAS SET RECOVERY FULL

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- BACKUP DO BANCO DE DADOS.

USE SUCOS_VENDAS

-- Backup do banco de dados.
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_II.BAK'

-- Backup do banco de dados com critério informando que este é o primeiro backup do banco de dados.
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_II.BAK' WITH INIT

-- Backup do banco de dados com critério informando que será feito uma compressão no banco visando diminuir seu tamanho.
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPRESSION.BAK' WITH COMPRESSION

-- Backup do arquivo de logo do banco de dados.
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_LOG.BAK'

-- Backup do arquivo de logo do banco de dados com critério informando que será feito uma compressão no arquivo visando diminuir seu tamanho.
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_LOG_COMPRESSION.BAK' WITH COMPRESSION

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- RECUPERAÇÃO DE BANCO DE DADOS.

-- Verificar estado dos backups que serão realizados, se estão íntegros, se não estão.
RESTORE VERIFYONLY FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS.BAK'
RESTORE VERIFYONLY FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS.BAK' WITH CHECKSUM

-- Explora um arquivo de backup válido e retorna um conjutno de resultados com todos os backups que foram salvos em sua ordem dentro daquele arquivo de backup. Ele traz as informações em forma de tabela.
RESTORE HEADERONLY FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS.BAK'

-- Conectar banco de dados para usuário entrar. Deixa o banco de dados disponível.
ALTER DATABASE SUCOS_VENDAS SET RECOVERY FULL
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS.BAK' WITH INIT

SELECT * FROM [NOTAS FISCAIS] WHERE [DATA] = '20180404'

USE MASTER
ALTER DATABASE SUCOS_VENDAS SET SINGLE_USER WITH ROLLBACK IMMEDIATE -- RETIRA DO AR O BANCO DE DADOS.
DROP DATABASE SUCOS_VENDAS
RESTORE DATABASE SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS.BAK' WITH RECOVERY

USE SUCOS_VENDAS
SELECT * FROM [NOTAS FISCAIS] WHERE [DATA] = '20180404'

BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK' WITH INIT

BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK'

BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK'

BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK'

RESTORE HEADERONLY FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK'

USE MASTER
ALTER DATABASE SUCOS_VENDAS SET SINGLE_USER WITH ROLLBACK IMMEDIATE -- RETIRA DO AR O BANCO DE DADOS.
DROP DATABASE SUCOS_VENDAS -- APAGAR BANCO DE DADOS.
RESTORE DATABASE SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS1.BAK' WITH FILE = 3, RECOVERY -- RECUPERAÇÃO DO BANCO DE DADOS.

RECOVERY -- IREI RECUPERAR SOMENTE ESTE ARQUIVO.
NORECOVERY -- IREI RECUPERAR MAIS ARQIVOS APÓS ESTE.

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

USE SUCOS_VENDAS
CREATE TABLE TST_BACKUP (POS INT)
INSERT INTO TST_BACKUP (POS) VALUES (1)
SELECT * FROM TST_BACKUP

-- 1:00 AM -- BACKUP FULL INICIAL

INSERT INTO TST_BACKUP (POS) VALUES (1)
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH INIT

-- 4:00 AM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (2)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 6:00 AM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (3)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 8:00 AM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (4)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 9:00 AM - BACKUP DIFERENCIAL
INSERT INTO TST_BACKUP (POS) VALUES (5)
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH DIFFERENTIAL

-- 10:00 AM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (6)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 12:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (7)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 14:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (8)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 14:00 PM - BACKUP DIFERENCIAL
INSERT INTO TST_BACKUP (POS) VALUES (9)
BACKUP DATABASE SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH DIFFERENTIAL

-- 15:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (10)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 17:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (11)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT


-- 17:30 - RECUPEROU BACKUP


-- 19:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (12)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

-- 21:00 PM - BACKUP LOG
INSERT INTO TST_BACKUP (POS) VALUES (13)
BACKUP LOG SUCOS_VENDAS TO DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH NOINIT

SELECT * FROM TST_BACKUP

RESTORE HEADERONLY FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'


-- quero recuperar os dados de 17:300 PM

-- 1:00 AM -- BACKUP FULL INICIAL (1)
-- 14:00 PM - BACKUP DIFERENCIAL (9)
-- 15:00 PM - BACKUP LOG (10)
-- 17:00 PM - BACKUP LOG (11)

USE MASTER
ALTER DATABASE SUCOS_VENDAS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE SUCOS_VENDAS

-- 1:00 AM -- BACKUP FULL INICIAL (1)
RESTORE DATABASE SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH FILE = 1, NORECOVERY
-- 14:00 PM - BACKUP DIFERENCIAL (9)
RESTORE DATABASE SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH FILE = 9, NORECOVERY
-- 15:00 PM - BACKUP LOG (10)
RESTORE LOG SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH FILE = 10, NORECOVERY
-- 17:00 PM - BACKUP LOG (11)
RESTORE LOG SUCOS_VENDAS FROM DISK = 'D:\Programas\Microsoft SQL Server 2019\SQLServer2019\BackupFiles\SUCOS_VENDAS_COMPLETO.BAK'
WITH FILE = 11, RECOVERY

USE SUCOS_VENDAS
SELECT * FROM TST_BACKUP

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- Criar novo usuário e senha.
CREATE LOGIN [DBA] WITH PASSWORD = 'TESTELOCAL'
CREATE LOGIN [DBA2] WITH PASSWORD = 'DBA2'

-- Dropar usuário.
DROP LOGIN [DBA2]

-- Verificar informação dos usuários.
SELECT * FROM [sys].[sql_logins]

-- Verificar informação dos usuários.
SELECT * FROM master.sys.sql_logins

-- Nome do usuário e último horário que o usuário logou no sistema.
SELECT name, LOGINPROPERTY(name, 'PasswordLastSetTime') FROM master.sys.sql_logins

-- Verificar se temos usuários com o nome de login com esse mesmo nome aplicado na senha. Server para informar que é viável trocar a senha.
SELECT SERVERPROPERTY('DESKTOP-FJJKLLE') AS SERVER_NAME, NAME AS LOGIN_NAME FROM master.sys.sql_logins
WHERE PWDCOMPARE(NAME, PASSWORD_HASH) = 1

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- Inserir autorizações para os usuário, por exemplo, sysadmin, public, dbcreator, etc. Temos 9 tipos de autorizações no SQL SERVER.
-- Neste caso foi adicionado a autorização dbcreator, onde o usuário pode gerenciar bancos de dados no SQL Server.
ALTER SERVER ROLE [dbcreator] ADD MEMBER [DBA2]
ALTER SERVER ROLE [dbcreator] DROP MEMBER [DBA2]

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- Verificar todas permissões a nível de servidor.
SELECT * FROM SYS.fn_builtin_permissions('') WHERE CLASS_DESC = 'SERVER'

USE SUCOS_VENDAS
CREATE LOGIN JORGE WITH PASSWORD = 'TESTE'
CREATE USER JORGE FOR LOGIN JORGE

USE SUCOS_VENDAS
EXEC sp_addrolemember 'db_datareader', 'JORGE'

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- PERFORMANCE

-- Simulando processos de performance. Mais leve.

USE SUCOS_VENDAS;
 
IF OBJECT_ID(' dbo.Nums2', 'U') IS NOT NULL DROP TABLE dbo.Nums2; 
CREATE TABLE dbo.Nums2( n float );

DECLARE @max AS INT, @rc AS INT; 
 SET @max = 3600; 
 SET @rc = 1; 
 WHILE @rc < = @max 
 BEGIN 
 DECLARE @X AS FLOAt
 SELECT @X = SUM(QUANTIDADE) FROM [ITENS NOTAS FISCAIS]
 INSERT INTO dbo.Nums2 (n) values (@X);
 SET @rc = @rc + 1;
 WAITFOR DELAY '00:00:02';  
 END


-- Simulando processos de performance. Mais pesado.

SET NOCOUNT ON; 

USE SUCOS_VENDAS;
 
IF OBJECT_ID(' dbo.Nums', 'U') IS NOT NULL DROP TABLE dbo.Nums; 
CREATE TABLE dbo.Nums( n INT NOT NULL PRIMARY KEY);

 DECLARE @max AS INT, @rc AS INT; 
 SET @max = 30000000; 
 SET @rc = 1; 
 INSERT INTO Nums VALUES( 1); 
 WHILE @rc * 2 < = @max 
 BEGIN 
 
 INSERT INTO dbo.Nums SELECT n + @rc FROM dbo.Nums; 
 SET @rc = @rc * 2; 
 
 END 
 INSERT INTO dbo.Nums SELECT n + @rc FROM dbo.Nums WHERE n + @rc < = @max;

SELECT n, n +  1 AS n_plus_one FROM dbo.Nums WHERE n < = 30000000;

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- REDUZINDO TAMANHO DA BASE DE DADOS:

USE SUCOS_VENDAS
ALTER DATABASE SUCOS_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('SUCOS_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('SUCOS_VENDAS', TRUNCATEONLY)
ALTER DATABASE SUCOS_VENDAS SET RECOVERY FULL

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- Testes para verificaçõa no SQL Profiler, visando verificar os processos executados.

SELECT * FROM [NOTAS FISCAIS] WHERE NUMERO = '100'

SELECT * FROM [NOTAS FISCAIS] 

SELECT * FROM [TABELA DE CLIENTES] A INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF INNER JOIN [ITENS NOTAS FISCAIS] C ON B.NUMERO = C.NUMERO

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- Teste para verificação no SQL Profiler, visando verificar os processos executados, porém, o comando abaixo tem um número elevado de linhas.

USE SUCOS_VENDAS;
 
IF OBJECT_ID(' dbo.Nums', 'U') IS NOT NULL DROP TABLE dbo.Nums; 
CREATE TABLE dbo.Nums( n INT NOT NULL PRIMARY KEY);

 DECLARE @max AS INT, @rc AS INT; 
 SET @max = 10000000; 
 SET @rc = 1; 
 INSERT INTO Nums VALUES( 1); 
 WHILE @rc * 2 < = @max 
 BEGIN 
 
 INSERT INTO dbo.Nums SELECT n + @rc FROM dbo.Nums; 
 SET @rc = @rc * 2; 
 
 END 
 INSERT INTO dbo.Nums SELECT n + @rc FROM dbo.Nums WHERE n + @rc < = @max;

SELECT n, n +  1 AS n_plus_one FROM dbo.Nums WHERE n < = 10000000;

--------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

-- ÍNDICES:

-- Testando índices:

-- Diferença é que não foi colcoado mais n como PRIMARY KEY.
-- Criar nums duas vezes. Executar a consulta com e sem índice
-- Verificar no TRACE.

USE SUCOS_VENDAS;

SET NOCOUNT ON
 
CREATE TABLE dbo.Nums1( n varchar(10) NOT NULL);
CREATE TABLE dbo.Nums2( n varchar(10) NOT NULL);

 DECLARE @max AS INT, @rc AS INT; 
 SET @max = 500000; 
 SET @rc = 1; 
 INSERT INTO Nums1 VALUES( 1); 
 INSERT INTO Nums2 VALUES( 1);
 WHILE @rc * 2 < = @max 
 BEGIN 
 
 INSERT INTO dbo.Nums1 SELECT convert(varchar(10), n + @rc) FROM dbo.Nums1; 
 INSERT INTO dbo.Nums2 SELECT convert(varchar(10), n + @rc) FROM dbo.Nums2; 
 SET @rc = @rc * 2; 
 
 END 
 INSERT INTO dbo.Nums1 SELECT convert(varchar(10), n + @rc) FROM dbo.Nums1 WHERE n + @rc < = @max;
 INSERT INTO dbo.Nums2 SELECT convert(varchar(10), n + @rc) FROM dbo.Nums2 WHERE n + @rc < = @max;

 SET NOCOUNT OFF

 CREATE NONCLUSTERED INDEX IX_Nums ON nums1 (n)

 SELECT N FROM Nums1 where N = '10001'
 SELECT N FROM Nums2 where N = '10001'

 SELECT @@SPID

 --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x --------- x 

 -- INDICAÇÃO PARA CRIAÇÃO DE INDICES:

 SELECT  sys.objects.name
, (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans) AS Impact
,  'CREATE NONCLUSTERED INDEX ix_IndexName ON ' + sys.objects.name COLLATE DATABASE_DEFAULT + ' ( ' + IsNull(mid.equality_columns, '') + CASE WHEN mid.inequality_columns IS NULL
                THEN '' 
    ELSE CASE WHEN mid.equality_columns IS NULL
                    THEN '' 
        ELSE ',' END + mid.inequality_columns END + ' ) ' + CASE WHEN mid.included_columns IS NULL
                THEN '' 
    ELSE 'INCLUDE (' + mid.included_columns + ')' END + ';' AS CreateIndexStatement
, mid.equality_columns
, mid.inequality_columns
, mid.included_columns 
    FROM sys.dm_db_missing_index_group_stats AS migs 
            INNER JOIN sys.dm_db_missing_index_groups AS mig ON migs.group_handle = mig.index_group_handle 
            INNER JOIN sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle AND mid.database_id = DB_ID() 
            INNER JOIN sys.objects WITH (nolock) ON mid.OBJECT_ID = sys.objects.OBJECT_ID 
    WHERE     (migs.group_handle IN
        ( 
        SELECT     TOP (500) group_handle 
            FROM          sys.dm_db_missing_index_group_stats WITH (nolock) 
            ORDER BY (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans) DESC))  
        AND OBJECTPROPERTY(sys.objects.OBJECT_ID, 'isusertable')=1 
    ORDER BY 2 DESC , 3 DESC


-- INDICAÇÃO DE ÍNDICES QUE ESTÃO SENDO POUCO UTILIZADOS E PODEM SER EXCLUÍDOS. MAS DEPENDE DA FREQUÊNCIA DE UTILIZAÇÃO.
-- INDICAR ÍNDICES OBSOLETOS.

SELECT o.name, indexname=i.name, i.index_id 
, reads=user_seeks + user_scans + user_lookups 
, writes = user_updates 
, rows = (SELECT SUM(p.rows) FROM sys.partitions p WHERE p.index_id = s.index_id AND s.object_id = p.object_id)
, CASE
 WHEN s.user_updates < 1 THEN 100
 ELSE 1.00 * (s.user_seeks + s.user_scans + s.user_lookups) / s.user_updates
 END AS reads_per_write
, 'DROP INDEX ' + QUOTENAME(i.name) 
+ ' ON ' + QUOTENAME(c.name) + '.' + QUOTENAME(OBJECT_NAME(s.object_id)) as 'drop statement'
FROM sys.dm_db_index_usage_stats s 
INNER JOIN sys.indexes i ON i.index_id = s.index_id AND s.object_id = i.object_id 
INNER JOIN sys.objects o on s.object_id = o.object_id
INNER JOIN sys.schemas c on o.schema_id = c.schema_id
WHERE OBJECTPROPERTY(s.object_id,'IsUserTable') = 1
AND s.database_id = DB_ID() 
AND i.type_desc = 'nonclustered'
AND i.is_primary_key = 0
AND i.is_unique_constraint = 0
AND (SELECT SUM(p.rows) FROM sys.partitions p WHERE p.index_id = s.index_id AND s.object_id = p.object_id) > 10000
ORDER BY reads