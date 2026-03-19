-- Objetivo: identificar o mês da primeira compra de cada cliente

SELECT 
    cliente_id,
    DATE_TRUNC('month', MIN(data_pedido)) AS primeira_compra
FROM pedidos
GROUP BY cliente_id
ORDER BY cliente_id;