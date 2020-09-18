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