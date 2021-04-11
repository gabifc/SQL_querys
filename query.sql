-- selecionando todos os nomes dos clientes 
SELECT FirstName, MiddleName, LastName
FROM person.Person

-- distinct para selecionar só os registros únicos. Registros unicos de sobrenome
SELECT DISTINCT LastName
FROM person.Person

-------------------- WHERE 
-- selecionar o nome e sobrenome especifico
SELECT *
FROM person.Person
WHERE LastName = 'miller' and FirstName = 'victoria'

SELECT *
FROM Production.Product
WHERE Color = 'blue' or Color = 'black' and ListPrice > 1500

SELECT *
FROM Production.Product
WHERE ListPrice > 1700.99 and ListPrice < 5000

/*Operador - Descrição
    <>       DIFERENTE DE      */

SELECT *
FROM Production.Product
WHERE Color <> 'red'

-- nome de todas as peças que pesam mais de 500kg até 700kg
Select Name, Weight
FROM Production.Product
WHERE Weight > 500 AND Weight <= 700

-- relacao de empregados (employees) casados e asalariados (salaried)
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'm' AND SalariedFlag = 1

-- consiga o email do usuario PETER KREBS  
--resposta- primeiro consido o BusinessEntityID 
SELECT *
FROM Person.Person
WHERE FirstName = 'peter' AND LastName = 'krebs'
-- com o business id pego o email
SELECT EmailAddress
FROM Person.EmailAddress
WHERE BusinessEntityID = 26

----------------------------------- COUNT 
-- retorna o nr de linhas que atende a condição
SELECT COUNT(*) -- para pegar tudo, inclusive valores nulos e repetidos
-- posso incluir o DISTINCT para não incluir os valores nulos e repetidos
SELECT COUNT(DISTINTC nomedacoluna)
FROM NOME DA TABELA

SELECT COUNT(*)
FROM Person.Person

SELECT COUNT(DISTINCT title)
FROM Person.Person

-- quantos produtos temos cadastrados na tab de production.product
SELECT COUNT(*)
FROM Production.Product

--quantos tamanhos de produtos temos cadastrado no bd
-- se usar o distinct pego só os diferentes
SELECT COUNT(size)
FROM Production.Product

-----------------------TOP 
-- limita a quantidade exibida no resultado. 
--Ex. Quero só as 10 primeiras linhas da tabela produção coluna produto
SELECT TOP 10 *
FROM Production.Product


-------------------- ORDER BY 
-- ordena os resultados por alguma coluna em ordem crescente ou decrescente
SELECT FirstName, LastName
FROM person.Person
ORDER BY FirstName asc, LastName asc  -- asc traz em ordem alfabetica de a - z
-- SQL server não precisa do asc, ele coloca de a a z automaticamente

-- obter o ProductID dos 10 produtos mais caros.
SELECT TOP 10 ProductID, ListPrice
FROM Production.Product
ORDER BY ListPrice desc

-- obter nome e nr do produto que tem product id entre 1 e 4
SELECT Name, ProductNumber, ProductID
FROM Production.Product
WHERE ProductID >= 1 AND ProductID <= 4
ORDER BY ProductID asc
--usando between
SELECT Name, ProductNumber, ProductID
FROM Production.Product
WHERE ProductID between 1 AND  4
ORDER BY ProductID asc

SELECT TOP 4 ProductID, Name, ProductNumber
FROM Production.Product
ORDER BY ProductID asc

-------------------------- BETWEEN 
-- usado para encontrar valor entre um valor minimo e maximo
SELECT *
FROM Production.Product
WHERE ListPrice between 1000 and 1500 

---------------------- NOT BETWEEN 
--lista os valores que não estão entre os valores declarados. ex: não estão entre 1000 e 1500
SELECT *
FROM Production.Product
WHERE ListPrice NOT between 1000 and 1500 

-- lista de funcionarios registrados no ano de 2009
SELECT *
FROM HumanResources.Employee
WHERE HireDate between '2009/01/01' and '2009/12/31'
ORDER BY HireDate asc


---------------------- IN 
-- usamos junto com o Where p verificar se um valor corresponde com qualquer valor passado na lista de valores. 
-- ele faz uma busca no bd e sempre que encontrar o valor que esta dentro dos ('valor1','valor2') ele retorna na lista.
-- pode receber uma subconsulta dentro. ex:  valor in (SELECT valor FROM nomeDaTabela)

SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (2,7,13)

-- sem o IN
SELECT *
FROM Person.Person
WHERE BusinessEntityID = 2
OR BusinessEntityID = 7
OR BusinessEntityID = 13

------------------------ NOT IN 
-- retorna tudo que não estiver dentro desta condição
SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2,7,13)

--------------------- LIKE 
-- encontra valores parecidos. EX: para encontrar um nome que tem "ovi"
-- a posição do % indica o local onde ele deve buscar, neste caso ele considerará qualquer valor que está depois do ovi.
-- sendo assim, indico que deve obrigatoriamente iniciar com ovi
-- posso utilizar %ovi% para ele considerar antes e depois %ovi quando sei que ovi está no final
-- Com underline: %ro_ no lugar do _ ele substitui por um valor, somente no local do underline, 1 letra no caso
-- independe ser maiusculo ou minusculo
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'ovi%'

-- Exercicios

-- quantos produtos cadastrados no sistema custam mais de 1500?
-- resposta 39
SELECT COUNT(ListPrice) -- pode ser * ou nome da coluna
FROM Production.Product
WHERE ListPrice > 1500

-- quantas pessoas temos com o sobrenome que inicia com a letra p
-- 1187
SELECT COUNT(LastName)
FROM Person.Person
WHERE LastName LIKE 'P%'

-- em quantas cidades unicas estão cadastrados os nossos clientes
--19614
SELECT DISTINCT COUNT(City)
FROM Person.Address

-- quais são as cidades unicas cadastradas
Select DISTINCT(City)
FROM Person.Address

-- quantos produtos vermelhos tem preco entre 500 a 1000 dolares
SELECT COUNT(*)
FROM Production.Product
WHERE Color = 'red' AND ListPrice BETWEEN 500 AND 1000

-- quantos produtos cadastrados tem a palavra 'road' no nome
SELECT COUNT(Name) -- tbm pode ser *
FROM Production.Product
WHERE Name LIKE '%road%'


------------------ MIN MAX SUM AVG
-- funções de agregação basicamente agregam ou combinam dados de uma tabela em 1 só resultado

-- AS define um apelido para a tabela, sem o as o resultado exibe Nenhum nome de coluna com o AS exibe 'Soma' como declarado

-- SUM: dentro do () a coluna que será somada
SELECT SUM(linetotal) AS 'Soma'
FROM Sales.SalesOrderDetail

-- MIN: qual o menor valor que tenho na tabela Sales
SELECT MIN(linetotal) AS 'MenorValor'
FROM Sales.SalesOrderDetail

-- MAX: qual valor maximo cadastrado na tabela sales
SELECT MAX(linetotal) AS 'MaiorValor'
FROM Sales.SalesOrderDetail

-- AVG: qual a media de valores da tabela sales
SELECT AVG(linetotal) AS 'ValorMedio'
FROM Sales.SalesOrderDetail


------------------ GROUP BY 
-- divide o resultado da pesquisa em grupos.
-- qdo usar AVG, MAX, MIN e SUM com 2 tabelas precisa usar o Group BY 
--Para cada grupo posso aplicar uma função de agregação. sintaxe:
SELECT coluna1, funcaoAgregacao(coluna2)
FROM nomeTabela
GROUP BY coluna1

-- na tab Sales quero agrupar a coluna SpecialOfferID com UnitPrice somada, o total 
-- aqui ele seleciona todos as linhas com o mesmo id e soma a coluna unitPrice. Todos os ids 9 somam X valor
-- apresenta o resultado separado por id e a soma total
SELECT SpecialOfferID, SUM(UnitPrice) AS 'SOMA'
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID

-- para identificar as linhas que ele agrupou e somou
-- retorna 61 linhas que na query de cima foram somadas e agrupadas
SELECT SpecialOfferID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE SpecialOfferID = 9

-- quero saber quantidade(COUNT) vendida de cada produto até hoje
-- aqui conto quantas vezes cada id aparece na tabela de vendas
SELECT ProductID, COUNT(ProductID) AS 'QuantidadeDeVendas'
FROM Sales.SalesOrderDetail
GROUP BY ProductID

-- soma total de todos os produtos por ID
SELECT ProductID, SUM(LineTotal) AS 'VendaTotal'
FROM Sales.SalesOrderDetail
GROUP BY ProductID

-- quantos nomes de cada nome temos cadastrado no BD
SELECT FirstName, COUNT(FirstName) AS 'TotalNome'
FROM Person.Person
GROUP BY FirstName

-- na tabela production quero saber a média de preço para os produtos que são prata(silver)
Select *
FROM Production.Product

SELECT Color, AVG(ListPrice) AS 'MediaPreço'
FROM Production.Product
WHERE Color = 'silver' -- removendo a condição WHERE, lista todas as cores
GROUP BY Color

-- quantas pessoas tem o mesmo middleName?
SELECT MiddleName, COUNT(MiddleName) AS 'TotalNomesDoMeioIguais'
FROM Person.Person
GROUP BY MiddleName

-- em média qual é a quantidade que cada produto é vendade na loja
SELECT ProductID, AVG(OrderQty) AS 'MediaVendas'
FROM Sales.SalesOrderDetail
GROUP BY ProductID

-- Quais foram as 10 vendas que no total(SUM) tiveram maiores valor de venda por produto do maior valor para o menor
SELECT TOP 10 ProductID, SUM(LineTotal) AS 'MaiorValorVenda'
FROM Sales.SalesOrderDetail
GROUP BY ProductID 
ORDER BY SUM(LineTotal) DESC

-- quantos produtos (COUNT) e qual a quantidade media (AVG) de produtos temos cadastrados nas nossas ordens de serviços (WorkOrder)
-- agrupados por productID
SELECT ProductID, 
	COUNT(ProductID) AS 'ContagemProdutos',
	AVG(WorkOrderID) AS 'MediaProdutos'
FROM Production.WorkOrder
GROUP BY ProductID

---------------------- HAVING
-- junção com o GROUP BY para filtrar resultados de um agrupamento. Um tipo de Where (condição) para dados agrupados.
--sintaxe
SELECT coluna1, FuncaoAgregacao(coluna2)
FROM nomeTabela
GROUP BY coluna1
HAVING  condicao -- aplicada aos dados agrupados na linha acima com o GROUP BY

-- quero saber quais nomes no sistema tem ocorrência maior que 10 vezes
SELECT FirstName, COUNT(FirstName) AS 'NumOcorrencia'
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10
ORDER BY NumOcorrencia ASC 

-- quais produtos estão entre 162k e 500k no total de vendas
SELECT ProductID, SUM(LineTotal) AS 'Total'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) between 162000 and 500000

-- usando HAVING E WHERE juntos
-- quero saber quais nomes no sistema tem ocorrência maior que 10 vezes onde o título é 'Mr'
SELECT FirstName, COUNT(FirstName) AS 'NumOcorrencia'
FROM Person.Person
WHERE Title = 'Mr.'
GROUP BY FirstName
HAVING COUNT(FirstName) > 10

-- Identifique as provincias (StateProvinceId) com o maior numero de cadastros no nosso sistema. Encontre quais provincias estão 
-- registradas mais que 1000 vezes
SELECT StateProvinceID, COUNT(StateProvinceID) AS 'TotalProvincias'
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000

-- Quais produtos (productID) não estão trazendo em média no mínimo 1 milhão em total de vendas (lineTotal)
SELECT ProductID, AVG(LineTotal) AS 'MediaVendas'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) > 1.000000

---------------------- AS 
-- Renomear as colunas, dar um apelido.
-- quando uso apenas uma palavra não precisa de AS, ex. Preco.
-- Para duas ou mais palavras precisa de '', ex. 'Preco do Produto'
SELECT FirstName AS Nome, LastName AS Sobrenome
FROM Person.Person

SELECT ProductNumber AS 'Numero do Produto'
FROM Production.Product

SELECT UnitPrice AS 'Preço Unitário'
FROM Sales.SalesOrderDetail

------------------- INNER JOIN

--juntando todos os dados de duas tabelas
SELECT *
FROM Person.BusinessEntityAddress AS BA
INNER JOIN Person.Address AS PA
ON PA.AddressID = BA.AddressID

-- juntando colunas: BusinessEntityID, FirstName, LastName, EmailAddress
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pe.EmailAddress
FROM Person.Person AS P
INNER JOIN Person.EmailAddress AS PE ON p.BusinessEntityID = pe.BusinessEntityID

-- juntando colunas: ListPrice, Nome do Produto, Nome da Subcaterogia
SELECT * 
FROM Production.Product

SELECT * 
FROM Production.ProductSubcategory
-- coluna comum PRoductSubcategoryID

SELECT pr.Name AS 'Nome Produto', pc.Name AS 'Nome Categoria', pr.ListPrice
FROM Production.Product AS pr
INNER JOIN Production.ProductSubcategory AS pc 
ON pr.ProductSubcategoryID = pc.ProductSubcategoryID 

-- juntar PhoneNumberTye com PersonPhone: BusinessEntityID, Name, PhoneNumberTypeId, PhoneNumber
SELECT pp.BusinessEntityID, pt.Name, pp.PhoneNumberTypeId, pp.PhoneNumber
FROM Person.PhoneNumberType AS PT
INNER JOIN Person.PersonPhone AS PP
ON PT.PhoneNumberTypeID = PP.PhoneNumberTypeID

-- juntar person.stateprovince e person.adress: AdressId, City, StateProviceId, Name
SELECT pa.AddressID, pa.City, ps.StateProvinceID, ps.Name
FROM Person.StateProvince AS PS
INNER JOIN Person.Address AS PA
ON PS.StateProvinceID = PA.StateProvinceID

--------------------- LEFT e INNER JOIN
-- quais pessoas tem cartão de crédito registrado
--usando INNER
SELECT *
FROM Person.Person AS PP
INNER JOIN Sales.PersonCreditCard AS PC
ON PP.BusinessEntityID = PC.BusinessEntityID
-- retorna 19118 linhas

-- usando LEFT
SELECT *
FROM Person.Person AS PP
LEFT JOIN Sales.PersonCreditCard AS PC
ON PP.BusinessEntityID = PC.BusinessEntityID
-- retorna 19972 linhas pq considera as pessoas que não tem cartão de credito registrado. Inclui todas as pessoas da tabela pp
SELECT 19972 - 19118 -- para verificar quantas linhas de diferença entre LEFT e INNER = 854

-- para selecionar somente estas pessoas que estão sem cartão de credito
SELECT *
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC
ON PP.BusinessEntityID = PC.BusinessEntityID
WHERE PC.CreditCardID IS NULL
-- retorna 854 linhas

---------------------- UNION 
-- combina dois ou mais resultados de um select.
-- sintaxe
SELECT coluna1, coluna2 -- precisa selecionar a mesma quantidade de coluna e o mesmo tipo de dado
FROM tabela1 -- posso trabalhar com a mesma tabela ou outra tabela
UNION -- remove os dados duplicados. Para pegar os duplicados uso UNION ALL
SELECT coluna1, coluna2 -- precisa selecionar a mesma quantidade de coluna e o mesmo tipo de dado
FROM tabela2 ou tabela1 -- uso a mesma tabela1 ou outra
-- Pode ser utilizado em tabelas não normalizadas

--Exemplo1
SELECT ProductID, Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Chain%'
UNION
SELECT ProductID, Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Decal%'

--Exemplo2
SELECT FirstName, MiddleName, Title -- este select sozinho retorna 577 linhas
FROM Person.Person
WHERE Title = 'Mr.' 
UNION -- Unindo os 2 selects retorna 936 linhas
SELECT FirstName, MiddleName, Title -- este select sozinho retorna 1319 linhas
FROM Person.Person
WHERE MiddleName = 'A'

-- DATEPART - extrair dados com tipo de informação data
-- DATAPART(1º param é a data: mes, ano, dia, semestre e o 2ºparam é a coluna que tem a data pedida)
SELECT SalesOrderId, DATEPART(YEAR, OrderDate) AS Ano
FROM Sales.SalesOrderHeader

SELECT SalesOrderId, DATEPART(MONTH, OrderDate) AS Mês
FROM Sales.SalesOrderHeader

-- qual a média de valor devido por mês - TotalDue
SELECT AVG(TotalDue) AS 'Média Devida', DATEPART(MONTH, OrderDate) AS Mes
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(MONTH, OrderDate)
ORDER BY Mes


--------------------------------------- STRING 
-- CONCAT 
-- uso o argumento CONCAT(aqui coloco os parametros, pode ser ilimitado)
-- inserir espaço entre os parametros
SELECT CONCAT(FirstName,' ', LastName) AS 'Nome completo'
FROM Person.Person

-- UPPER
--vletras em maiúscula e LOWER letras em minúscula
-- normalizar o dado string
SELECT UPPER(FirstName), LOWER(LastName)
FROM Person.Person

-- LEN 
-- Length contagem de caracteres da string
SELECT FirstName, LEN(FirstName) AS 'Quantidade de Letras'
FROM Person.Person

-- SUBSTRING 
-- extrair um trecho de uma string
-- 1º param é a coluna que quero (FirstName), 2º parametro é a posição do índice que ele inicia a coleta (1) que é a primeira letra
-- 3º parametro é a quantidade de caracteres (3) quero 3 letras.
SELECT FirstName, SUBSTRING(FirstName, 1, 3) -- quero as 3 primeiras letras do primeiro nome
FROM Person.Person

-- REPLACE
-- substituir dados na tabela
-- pode trabalhar com vários parametros
-- 1º param é a coluna, 2º o que ele busca para substituir(no 1º param) e 3º o que deve ser colocado no lugar
SELECT ProductNumber, REPLACE(ProductNumber, '-', '#') -- na coluna productnumber troca - por #
FROM Production.Product


----------------------- Operações Matemáticas
-- soma de 2 ou mais colunas
SELECT UnitPrice + LineTotal
FROM Sales.SalesOrderDetail
-- demais operações trocar o sinal de +

-- SUM - soma de uma coluna
SELECT SUM(LineTotal) 
FROM Sales.SalesOrderDetail

-- AVG - média
SELECT AVG(LineTotal) 
FROM Sales.SalesOrderDetail

--valor min da coluna
SELECT MIN(LineTotal) 
FROM Sales.SalesOrderDetail

--valor máximo da coluna
SELECT MAX(LineTotal) 
FROM Sales.SalesOrderDetail

-- ROUND
-- arredondamento de valor
--1º parametro de onde vem a info, qual coluna. 2º param a precisão decimal do arredondamento
SELECT LineTotal, ROUND(LineTotal,1)
FROM Sales.SalesOrderDetail
-- passa de 2024.994000 para 2525.000000
-- também posso arredondar para baixo utilizando -1

-- SQRT
-- raiz quadrada
SELECT SQRT(LineTotal)
FROM Sales.SalesOrderDetail

----------------------- SUBQUERY Subselect
-- selects dinâmicos
-- monte um relatório com todos os produtos que tenha preço de venda acima da média
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) 
					FROM Production.Product)
-- este select é dinâmico, diferente de fazer 2 selects, sendo 1 para achar a média e outro para listar os produtos.

-- nome dos funcionários que tem nome de designer enginner
-- com subselect
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID 
IN (
SELECT BusinessEntityID
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer')

-- com JOIN
SELECT P.FirstName
FROM Person.Person P
JOIN HumanResources.Employee E 
ON P.BusinessEntityID = E.BusinessEntityID
AND E.JobTitle = 'Design Engineer'