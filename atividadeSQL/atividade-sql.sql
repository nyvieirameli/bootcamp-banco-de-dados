-- 1 --
SELECT * FROM  clientes WHERE id_clientes > 5;
-- 2 --
SELECT * FROM  clientes WHERE id_clientes > 5 ORDER BY created_at DESC;
-- 3 --
SELECT * FROM  clientes WHERE id_clientes > 5 AND tipo LIKE 'PJ' ORDER BY created_at DESC;
-- 4 --
SELECT * FROM  clientes WHERE id_clientes > 5 AND tipo LIKE 'CPF' ORDER BY created_at DESC;
-- 5 --
SELECT * FROM pedidos WHERE created_at BETWEEN '2020-01-01' AND '2020-31-01';
-- 6 -- 
SELECT * FROM pedidos LIMIT 10;
--  7 -- 
SELECT DISTINCT categoria  FROM produtos;
-- 8 --
SELECT sum(valor_total) as 'Valor Total' FROM pedidos WHERE fk_cliente = 148 AND tipo LIKE 'renda';
-- 9 --
SELECT count(id_pedido) as 'cancelados' FROM pedidos WHERE status LIKE 'cancelado' GROUP BY status; 

