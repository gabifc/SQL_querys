-- Exercícios do curso Data Wrangling, Analysis and AB Testing with SQL
-- University of California, Davis

-- CAP 1- REVISÃO

-- EX #1 
--Edite a consulta para obter e-mail, mas apenas para usuários não excluídos.
SELECT id, email_address
FROM dsv1069.users
WHERE deleted_at ISNULL

-- EX #2 
-- Use a tabela de itens para contar o número de itens à venda em cada categoria

SELECT category, COUNT(id) AS item_count
FROM dsv1069.items
GROUP BY category
ORDER BY item_count DESC

-- EX #3 
--Selecione todas as colunas do resultado quando você JUNTA a tabela de usuários aos pedidos tabela

SELECT *
FROM  dsv1069.orders
JOIN dsv1069.users
ON orders.user_id = users.id
-- pode ter nome de coluna diferente, desde que o dado não seja diferente

-- EX #4 
--Confira a consulta abaixo. Esta não é a maneira certa de contar o número de views_item eventos. Determine o que está errado e corrija o erro.

SELECT COUNT(DISTINCT event_id) AS events
FROM dsv1069.events
WHERE event_name = 'view_item'

-- EX #5 
--Calcula o número de itens na tabela de itens que foram pedidos. 
-- A pergunta abaixo funciona, mas não está certo. Determine o que está 
-- errado e corrija o erro ou comece do zero.

-- Codigo inicial
SELECT 
COUNT(item_id) AS item_count
FROM dsv1069.orders
JOIN dsv1069.items 
ON orders.item_id = item_id
-- Retorna: 104189596 está errado pq se eu contar o nr de itens
-- o número é menor, ver abaixo.

SELECT COUNT(*) FROM dsv1069.items
-- Retorna: 2198

-- Posso fazer com ou sem o JOIN que terei o mesmo resultado
-- sem JOIN
SELECT 
COUNT(DISTINCT item_id) AS item_count
FROM dsv1069.orders
-- Retorna: 2198

-- com JOIN
SELECT 
COUNT(DISTINCT item_id) AS item_count
FROM dsv1069.orders
JOIN dsv1069.items 
ON orders.item_id = item_id
-- Retorna: 2198

-- EX #6
-- Objetivo: para cada usuário, descubra SE um usuário pediu algo e 
-- quando foi a primeira compra. A consulta abaixo não retorna 
-- informações de nenhum dos usuários que não fizeram pedidos.

-- CODIGO INICIAL ERRO
SELECT
users.id AS user_id 
MIN(orders.paid_at) AS min_paid_at
FROM dsv1069.orders --> users
JOIN dsv1069.users --> LEFT OUTER JOIN dsv1069.orders
ON orders.user_id = users.id
GROUP BY users.id

-- o que está errado é a ordem entre pedidos e usuários 
-- Pedidos é a tabela menor cerca de 5 mil linhas e a Usuários é a maior
-- cerca de 50 mil linhas. Se eu quero contar usuários devo começar 
-- a tabela users e em seguida pela esquerda juntar na tabela pedidos

SELECT
 users.id AS user_id, 
 MIN(orders.paid_at) AS min_paid_at
FROM dsv1069.users --> erro: era orders
LEFT OUTER JOIN dsv1069.orders --> erro: era só Join com users
ON orders.user_id = users.id
GROUP BY users.id

-- EX #7
--Goal: descobrir qual porcentagem de usuários já visualizaram a página 
-- de perfil, mas esta consulta não está certo. 
-- Verifique se o número de usuários foi adicionado e, se não, corrija a 
-- consulta.

-- Código inicial ERRADO - só retorna a % de true e preciso do false para comparar
SELECT 
(CASE WHEN first_view ISNULL THEN false
  ELSE true END) AS has_viewed_profile_page,
COUNT(user_id) AS users
FROM 
  (SELECT users.id AS user_id, 
  MIN(event_time) as first_view
FROM 
  dsv1069.users
  LEFT OUTER JOIN 
  dsv1069.events 
  ON 
  events.user_id = users.id
  WHERE 
  event_name = 'view_user_profile'
  GROUP BY 
  users.id
) first_profile_views
GROUP BY
(CASE WHEN first_view ISNULL THEN false 
ELSE true END)


-- verificar se o que vem primeiro é o users e depois o evento, usar left outer join e verificar separadamente 
-- a subconsulta. 
-- trocar o where por and
SELECT 
(CASE WHEN first_view ISNULL THEN false
  ELSE true END) AS has_viewed_profile_page,
COUNT(user_id) AS users
FROM 
  (SELECT users.id AS user_id, 
  MIN(event_time) as first_view
FROM 
  dsv1069.users
  LEFT OUTER JOIN 
  dsv1069.events 
  ON 
  events.user_id = users.id
  AND --> WHERE é errado pq limita minha visão 
  event_name = 'view_user_profile'
  GROUP BY 
  users.id
) first_profile_views
GROUP BY
(CASE WHEN first_view ISNULL THEN false 
ELSE true END)

-- Retorna:
-- false: 114143 
-- true: 3035

-- para calcular a % 
-- soma de false e true = 117.178
-- % de false: (114.143/117.178).100 = 97.40%
-- % de false: (3035/117.178).100 = 2.60%
-- ou
-- para calcular a % 
-- (3035 / 114143).100 = 2,65% - apenas 2,65% viram a página de perfil.
