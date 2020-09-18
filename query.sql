-- selecionando todos os nomes dos clientes 
SELECT FirstName, MiddleName, LastName
FROM person.Person

-- distinct para selecionar só os registros únicos. Registros unicos de sobrenome
SELECT DISTINCT LastName
FROM person.Person

--where - selecionar o nome e sobrenome especifico
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
--tentativa de join - REFAZER
SELECT EmailAddress, FirstName, LastName
FROM Person.EmailAddress
JOIN Person.Person ON Person.BusinessEntityID = 26 AND Person.FirstName = 'peter' AND Person.LastName = 'krebs'
--WHERE FirstName = 'peter' AND LastName = 'krebs'

--resposta- primeiro consido o BusinessEntityID 
SELECT *
FROM Person.Person
WHERE FirstName = 'peter' AND LastName = 'krebs'
-- com o business id pego o email
SELECT EmailAddress
FROM Person.EmailAddress
WHERE BusinessEntityID = 26

--count - retorna o nr de linhas que atende a condição
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

--TOP - limita a quantidade exibida no resultado. 
--Ex. Quero só as 10 primeiras linhas da tabela produção coluna produto
SELECT TOP 10 *
FROM Production.Product


-- ORDER BY - ordena os resultados por alguma coluna em ordem crescente ou decrescente
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

-- BETWEEN - usado para encontrar valor entre um valor minimo e maximo
SELECT *
FROM Production.Product
WHERE ListPrice between 1000 and 1500 

-- NOT BETWEEN lista os valores que não estão entre os valores declarados. ex: não estão entre 1000 e 1500
SELECT *
FROM Production.Product
WHERE ListPrice NOT between 1000 and 1500 

-- lista de funcionarios registrados no ano de 2009
SELECT *
FROM HumanResources.Employee
WHERE HireDate between '2009/01/01' and '2009/12/31'
ORDER BY HireDate asc


-- IN - usamos junto com o Where p verificar se um valor corresponde com qualquer valor passado na lista de valores. 
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

-- NOT IN - retorna tudo que não estiver dentro desta condição
SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2,7,13)

-- LIKE - encontra valores parecidos. EX: para encontrar um nome que tem "ovi"
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


-- MIN MAX SUM AVG
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


-- GROUP BY 
-- divide o resultado da pesquisa em grupos. 
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

