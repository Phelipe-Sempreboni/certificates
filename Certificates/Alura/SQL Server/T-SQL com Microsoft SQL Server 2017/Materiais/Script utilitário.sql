IF OBJECT_ID('SUCOS_VENDAS.dbo.TABELA_TESTE', 'U') IS NOT NULL
BEGIN
	DROP TABLE [SUCOS_VENDAS].[dbo].TABELA_TESTE
END
CREATE TABLE TABELA_TESTE
(
	ID VARCHAR(10)
)
GO

SELECT GETDATE()
SELECT DATENAME(WEEKDAY, DATEADD(DAY, 5, GETDATE()))
GO

DECLARE @DIA_SEMANA VARCHAR(20)
DECLARE @NUMERO_DIAS INT
SET @NUMERO_DIAS = 6
SET @DIA_SEMANA = DATENAME(WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()))
PRINT @DIA_SEMANA

IF @DIA_SEMANA = 'Sunday' OR @DIA_SEMANA = 'Saturday'
	PRINT 'Este dia é fim de semana'
ELSE
	PRINT 'Este dia é semana'
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

SELECT 
	 COUNT(CPF) AS [Qtde notas]
	,[DATA]
	,
	CASE
		WHEN COUNT(CPF) >= 70 THEN 'Muita nota'
		WHEN COUNT(CPF) < 70 THEN 'Pouca nota'
	END AS 'Observação'

FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS]

GROUP BY 
	[DATA]

ORDER BY 
	COUNT(CPF)
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

SELECT COUNT(CPF) AS [Qtde notas], [DATA] FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS] WHERE [DATA] = '20170102' GROUP BY [DATA]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

DECLARE @DATA_NOTA DATE
DECLARE @QTDE_NOTAS INT

SET @DATA_NOTA = '20170102'
SET @QTDE_NOTAS = (SELECT COUNT(CPF) AS [Qtde notas] FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS] WHERE [DATA] = @DATA_NOTA GROUP BY [DATA])

IF @QTDE_NOTAS > 70
    PRINT 'Muita nota'
ELSE
    PRINT 'Pouca nota'
PRINT @QTDE_NOTAS
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

DECLARE @LIMITE_MAXIMO FLOAT
DECLARE @LIMITE_ATUAL FLOAT
DECLARE @BAIRRO VARCHAR(20)

SET @BAIRRO = 'Jardins'
SET @LIMITE_MAXIMO = '450000'
SET @LIMITE_ATUAL = (SELECT SUM([LIMITE DE CREDITO]) FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES] WHERE [BAIRRO] = 'Jardins')

SELECT @LIMITE_ATUAL

IF @LIMITE_MAXIMO <= (@LIMITE_ATUAL)
BEGIN
	PRINT 'Valor estourou. Não é possível abrir novos créditos.'
END

ELSE
BEGIN
	PRINT 'Valor não estourou. É possível abrir novos créditos.'
END
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

DECLARE @LIMITE_MINIMO INT
DECLARE @LIMITE_MAX INT
DECLARE @LIMITE_BREAK INT

SET @LIMITE_MINIMO = 1
SET @LIMITE_MAX = 10
SET @LIMITE_BREAK = 10

WHILE @LIMITE_MINIMO <= @LIMITE_MAX
BEGIN
	PRINT @LIMITE_MINIMO
	SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1
	IF @LIMITE_MINIMO = @LIMITE_BREAK
	BEGIN
		PRINT 'Saindo pelo comando break'
		BREAK
	END
END
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

IF OBJECT_ID('SUCOS_VENDAS.dbo.TABELA DE NUMEROS', 'U') IS NOT NULL
	DROP TABLE [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]

CREATE TABLE [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]
(
	 [NUMERO] INT
	,[STATUS] VARCHAR (200)
)

DECLARE @LIMITE_MIN INT
DECLARE @LIMITE_MÁX INT
DECLARE @CONTADOR_NOTAS INT

SET @LIMITE_MIN = 1
SET @LIMITE_MÁX = 100000

SET NOCOUNT ON
WHILE @LIMITE_MIN <= @LIMITE_MÁX
BEGIN
	SELECT @CONTADOR_NOTAS = COUNT(*) FROM [NOTAS FISCAIS] WHERE [NUMERO] = @LIMITE_MIN
	IF @CONTADOR_NOTAS > 0
		INSERT INTO [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS] ([NUMERO], [STATUS]) VALUES (@LIMITE_MIN, 'É nota fiscal')
	ELSE
		INSERT INTO [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS] ([NUMERO], [STATUS]) VALUES (@LIMITE_MIN, 'Não é nota fiscal')
	SET @LIMITE_MIN = @LIMITE_MIN + 1
END
BEGIN
SET NOCOUNT OFF
END

SELECT * FROM [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]

TRUNCATE TABLE [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]

SELECT 
	 MIN([NUMERO])
	,MAX([NUMERO])

FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE TABLE #TABELA01 
(
	 [ID] VARCHAR(10) NULL
	,[NOME] VARCHAR(200) NULL
)

INSERT INTO #TABELA01 ([ID], [NOME]) VALUES ('1', 'João')
INSERT INTO #TABELA01 ([ID], [NOME]) VALUES ('2', 'Pedro')

SELECT * FROM #TABELA01
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE TABLE ##TABELA02 
(
	 [ID] VARCHAR(10) NULL
	,[NOME] VARCHAR(200) NULL
)

INSERT INTO ##TABELA02 ([ID], [NOME]) VALUES ('1', 'João')
INSERT INTO ##TABELA02 ([ID], [NOME]) VALUES ('2', 'Pedro')

SELECT * FROM ##TABELA02
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

IF OBJECT_ID('SUCOS_VENDAS.dbo.TABELA DE NUMEROS', 'U') IS NOT NULL
	DROP TABLE [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]

DECLARE @LIMITE_MINI INT
DECLARE @LIMITE_MÁXI INT
DECLARE @CONTADOR_NOTA INT
DECLARE @TABELA_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR (200))
CREATE TABLE #TABELA_NUMEROS2 ([NUMERO] INT, [STATUS] VARCHAR (200))

SET @LIMITE_MINI = 1
SET @LIMITE_MÁXI = 101

SET NOCOUNT ON
WHILE @LIMITE_MINI <= @LIMITE_MÁXI
BEGIN
	SELECT @CONTADOR_NOTA = COUNT(*) FROM [NOTAS FISCAIS] WHERE [NUMERO] = @LIMITE_MINI
	IF @CONTADOR_NOTA > 0
		BEGIN
			INSERT INTO @TABELA_NUMEROS ([NUMERO], [STATUS]) VALUES (@LIMITE_MINI, 'É nota fiscal')
			INSERT INTO #TABELA_NUMEROS2 ([NUMERO], [STATUS]) VALUES (@LIMITE_MINI, 'É nota fiscal')
		END
	ELSE
		BEGIN
			INSERT INTO @TABELA_NUMEROS ([NUMERO], [STATUS]) VALUES (@LIMITE_MINI, 'Não é nota fiscal')
			INSERT INTO #TABELA_NUMEROS2 ([NUMERO], [STATUS]) VALUES (@LIMITE_MINI, 'Não é nota fiscal')
		SET @LIMITE_MINI = @LIMITE_MINI + 1
	END
END
BEGIN
SET NOCOUNT OFF
END

SELECT * FROM @TABELA_NUMEROS
SELECT * FROM #TABELA_NUMEROS2
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE FUNCTION FaturamentoNota
(
	@Numero AS INT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @FATURAMENTO FLOAT
	SELECT @FATURAMENTO = SUM(QUANTIDADE * [PREÇO]) FROM [SUCOS_VENDAS].[dbo].[ITENS NOTAS FISCAIS] WHERE [NUMERO] = @Numero
	RETURN @FATURAMENTO
END
GO

SELECT NUMERO, [dbo].[FaturamentoNota] (NUMERO) AS FATURAMENTO FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE FUNCTION NumeroNotas
(
	@Data AS Date
)
RETURNS INT
AS
BEGIN
DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS] WHERE [DATA] = @Data
RETURN @NUMNOTAS
END
GO

SELECT [dbo].[NumeroNotas] ('20170202')
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

IF OBJECT_ID('SUCOS_VENDAS.dbo.TABELA DE NUMEROS', 'U') IS NOT NULL
	DROP TABLE [SUCOS_VENDAS].[dbo].[TABELA DE NUMEROS]

DECLARE @LIMITE_MINI INT
DECLARE @LIMITE_MÁXI INT
DECLARE @CONTADOR_NOTA INT
DECLARE @TABELA_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR (200), [FATURAMENTO] FLOAT)

SET @LIMITE_MINI = 98
SET @LIMITE_MÁXI = 102

SET NOCOUNT ON
WHILE @LIMITE_MINI <= @LIMITE_MÁXI
BEGIN
	SELECT @CONTADOR_NOTA = COUNT(*) FROM [NOTAS FISCAIS] WHERE [NUMERO] = @LIMITE_MINI
	IF @CONTADOR_NOTA > 0
		BEGIN
			INSERT INTO @TABELA_NUMEROS ([NUMERO], [STATUS], [FATURAMENTO]) VALUES (@LIMITE_MINI, 'É nota fiscal', [dbo].[FaturamentoNota](@LIMITE_MINI))
		END
	ELSE
		BEGIN
			INSERT INTO @TABELA_NUMEROS ([NUMERO], [STATUS], [FATURAMENTO]) VALUES (@LIMITE_MINI, 'Não é nota fiscal', 0)
		SET @LIMITE_MINI = @LIMITE_MINI + 1
	END
END
BEGIN
SET NOCOUNT OFF
END

SELECT * FROM @TABELA_NUMEROS
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE FUNCTION ListaNotasClientes
(
	@CPF AS VARCHAR (12)
)
RETURNS TABLE
AS
RETURN SELECT * FROM  [SUCOS_VENDAS].[dbo].[NOTAS FISCAIS] WHERE [CPF] = @CPF
GO

SELECT * FROM [dbo].[ListaNotasClientes] ('1471156710')
GO

SELECT COUNT(*) FROM [dbo].[ListaNotasClientes] ('1471156710')
GO

SELECT CPF, (SELECT COUNT(*) FROM [dbo].[ListaNotasClientes] ('1471156710')) AS [NUMT_NOTA]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE FUNCTION EnderecoCompleto
(
	 @ENDERECO VARCHAR(150)
	,@CIDADE VARCHAR (50)
	,@ESTADO VARCHAR(50)
	,@CEP VARCHAR (20)
)
RETURNS VARCHAR (250)
AS
BEGIN
	DECLARE @ENDERECO_COMPLETO VARCHAR(250)
	SET @ENDERECO_COMPLETO = @ENDERECO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP
	RETURN @ENDERECO_COMPLETO
END
GO

SELECT CPF, [dbo].[EnderecoCompleto] ([ENDERECO 1], [CIDADE], [ESTADO], [CEP]) AS END_COMPLETO FROM [dbo].[TABELA DE CLIENTES]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

ALTER FUNCTION EnderecoCompleto
(
	 @ENDERECO VARCHAR(150)
	,@CIDADE VARCHAR (50)
	,@ESTADO VARCHAR(50)
	,@CEP VARCHAR (20)
)
RETURNS VARCHAR (250)
AS
BEGIN
	DECLARE @ENDERECO_COMPLETO VARCHAR(250)
	SET @ENDERECO_COMPLETO = @ENDERECO + ', ' + @CIDADE + ', ' + @ESTADO + ', ' + @CEP
	RETURN @ENDERECO_COMPLETO
END
GO

SELECT CPF, [dbo].[EnderecoCompleto] ([ENDERECO 1], [CIDADE], [ESTADO], [CEP]) AS END_COMPLETO FROM [dbo].[TABELA DE CLIENTES]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

IF OBJECT_ID ('EnderecoCompleto2', 'FN') IS NOT NULL
DROP FUNCTION EnderecoCompleto2
GO

CREATE FUNCTION EnderecoCompleto2
(
	 @ENDERECO VARCHAR(150)
	,@CIDADE VARCHAR (50)
	,@ESTADO VARCHAR(50)
	,@CEP VARCHAR (20)
)
RETURNS VARCHAR (250)
AS
BEGIN
	DECLARE @ENDERECO_COMPLETO VARCHAR(250)
	SET @ENDERECO_COMPLETO = @ENDERECO + ' - ' + @CIDADE + ' - ' + @ESTADO + ' - ' + @CEP
	RETURN @ENDERECO_COMPLETO
END
GO

SELECT CPF, [dbo].[EnderecoCompleto] ([ENDERECO 1], [CIDADE], [ESTADO], [CEP]) AS END_COMPLETO FROM [dbo].[TABELA DE CLIENTES]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE PROCEDURE BuscaPorEntidades @ENTIDADE AS VARCHAR(10)
AS
BEGIN
	IF @ENTIDADE = 'CLIENTES'
		SELECT [CPF] AS IDENTIFICADOR, [NOME] AS DESCRITOR, [BAIRRO] AS BAIRRO FROM [TABELA DE CLIENTES]
	ELSE IF @ENTIDADE = 'VENDEDORES'
		SELECT [MATRICULA] AS IDENTIFICADOR, [NOME] AS DESCRITOR, [BAIRRO] AS BAIRRO FROM [TABELA DE VENDEDORES]
END

EXEC [dbo].[BuscaPorEntidades] @ENTIDADE = 'VENDEDORES'
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE PROCEDURE CalculaIdade
AS
BEGIN
	UPDATE [TABELA DE CLIENTES] SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) 
END
GO

INSERT INTO [TABELA DE CLIENTES] (CPF, NOME, [ENDERECO 1], [BAIRRO], CIDADE, ESTADO, CEP, [DATA DE NASCIMENTO], SEXO, [LIMITE DE CREDITO], [VOLUME DE COMPRA], [PRIMEIRA COMPRA]) 
VALUES
('123123123', 'JOÃO MACHADO', 'RUA PROJETADA A', 'MADUREIRA', 'Rio de Janeiro', 'RJ', '20000', '20000306', 'M', 12000, 12000, 12000)
GO

SELECT * FROM [TABELA DE CLIENTES]
GO

EXEC [dbo].[CalculaIdade]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 


EXEC sp_columns 'TABELA DE CLIENTES', @table_owner = 'dbo'
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE PROCEDURE BuscaNotasCliente
	 @CPF AS VARCHAR(12)
	,@DATA_INICIAL AS DATETIME = '20160101'
	,@DATA_FINAL AS DATETIME = '20161231'
AS
BEGIN
	SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF AND [DATA] >= @DATA_INICIAL AND [DATA] <= @DATA_FINAL
END
GO
----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

EXEC BuscaNotasCliente @CPF = '19290992743'

EXEC BuscaNotasCliente @CPF = '19290992743', @DATA_INICIAL = '20161201'

EXEC BuscaNotasCliente @CPF = '19290992743', @DATA_FINAL = '20160131'

SELECT * FROM [TABELA DE CLIENTES]

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

SELECT A.[CPF], A.[NOME], SUM(C.[QUANTIDADE] * C.[PREÇO]) AS FATURAMENTO

FROM [TABELA DE CLIENTES] AS A

INNER JOIN [NOTAS FISCAIS] AS B ON A.[CPF] = B.[CPF] AND YEAR(B.[DATA]) = 2016

INNER JOIN [ITENS NOTAS FISCAIS] AS C ON B.[NUMERO] = C.[NUMERO]

GROUP BY 
	 A.[CPF]
	,A.[NOME]

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE TYPE ListaClientes AS TABLE
(CPF VARCHAR(12) NOT NULL)

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

DECLARE @Lista AS ListaClientes
INSERT INTO @Lista (CPF) VALUES ('8502682733'), ('8719655770'), ('9283760794')
SELECT * FROM @Lista
GO
----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

DECLARE @Lista AS ListaClientes
INSERT INTO @Lista (CPF) VALUES ('8502682733'), ('8719655770'), ('9283760794')

SELECT A.[CPF], A.[NOME], SUM(C.[QUANTIDADE] * C.[PREÇO]) AS FATURAMENTO

FROM [TABELA DE CLIENTES] AS A

INNER JOIN [NOTAS FISCAIS] AS B ON A.[CPF] = B.[CPF] AND YEAR(B.[DATA]) = 2016

INNER JOIN [ITENS NOTAS FISCAIS] AS C ON B.[NUMERO] = C.[NUMERO]

INNER JOIN @Lista AS D ON A.[CPF] = D.[CPF]

GROUP BY 
	 A.[CPF]
	,A.[NOME]
GO

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

CREATE PROCEDURE FaturamentoClientes2016
	
	@LISTA AS ListaClientes READONLY

AS
BEGIN

SELECT A.[CPF], A.[NOME], SUM(C.[QUANTIDADE] * C.[PREÇO]) AS FATURAMENTO

FROM [TABELA DE CLIENTES] AS A

INNER JOIN [NOTAS FISCAIS] AS B ON A.[CPF] = B.[CPF] AND YEAR(B.[DATA]) = 2016

INNER JOIN [ITENS NOTAS FISCAIS] AS C ON B.[NUMERO] = C.[NUMERO]

INNER JOIN @LISTA AS D ON A.[CPF] = D.[CPF]

GROUP BY 
	 A.[CPF]
	,A.[NOME]

END
GO

DECLARE @Lista AS ListaClientes
INSERT INTO @Lista (CPF) VALUES ('8502682733'), ('8719655770'), ('9283760794')
EXEC FaturamentoClientes2016 @LISTA = @Lista

----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x ----- x 

