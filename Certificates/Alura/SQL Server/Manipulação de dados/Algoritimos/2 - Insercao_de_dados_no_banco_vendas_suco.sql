USE SUCOS_VENDAS

SELECT * FROM [SUCOS_VENDAS].[dbo].[TABELA DE PRODUTOS]

SELECT [CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA] FROM [SUCOS_VENDAS].[dbo].[TABELA DE PRODUTOS]

SELECT * FROM [VENDAS_SUCOS].[dbo].[PRODUTOS]

DELETE FROM [VENDAS_SUCOS].[dbo].[PRODUTOS]

INSERT INTO [VENDAS_SUCOS].[dbo].[PRODUTOS] ([CODIGO], [DESCRITOR], [SABOR], [TAMANHO], [EMBALAGEM], [PREÇO LISTA]) 
	SELECT [CODIGO DO PRODUTO] AS [CODIGO], [NOME DO PRODUTO] AS [DESCRITOR], [SABOR], [TAMANHO], [EMBALAGEM], [PREÇO DE LISTA] AS [PREÇO LISTA] 
		FROM [SUCOS_VENDAS].[dbo].[TABELA DE PRODUTOS]

------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x

DELETE FROM [VENDAS_SUCOS].[dbo].[CLIENTES]

SELECT [CPF]
      ,[NOME]
      ,[ENDEREÇO]
      ,[BAIRRO]
      ,[CIDADE]
      ,[ESTADO]
      ,[CEP]
      ,[DATA NASCIMENTO]
      ,[IDADE]
      ,[SEXO]
      ,[LIMITE DE CRÉDITO]
      ,[VOLUME DE COMPRA]
      ,[PRIMEIRA COMPRA]
  FROM [VENDAS_SUCOS].[dbo].[CLIENTES]

SELECT [CPF],[NOME],[ENDERECO 1] AS [ENDEREÇO],[BAIRRO],[CIDADE],[ESTADO],[CEP],[DATA DE NASCIMENTO] AS [DATA NASCIMENTO],[IDADE],[SEXO],[LIMITE DE CREDITO] AS [LIMITE DE CRÉDITO] ,[VOLUME DE COMPRA],[PRIMEIRA COMPRA] FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES]


  INSERT INTO [VENDAS_SUCOS].[dbo].[CLIENTES] ([CPF],[NOME],[ENDEREÇO],[BAIRRO],[CIDADE],[ESTADO],[CEP],[DATA NASCIMENTO],[IDADE],[SEXO],[LIMITE DE CRÉDITO],[VOLUME DE COMPRA],[PRIMEIRA COMPRA])
	SELECT [CPF],[NOME],[ENDERECO 1] AS [ENDEREÇO],[BAIRRO],[CIDADE],[ESTADO],[CEP],[DATA DE NASCIMENTO] AS [DATA NASCIMENTO],[IDADE],[SEXO],[LIMITE DE CREDITO] AS [LIMITE DE CRÉDITO] ,[VOLUME DE COMPRA],[PRIMEIRA COMPRA] 
		FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES]

------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x------x