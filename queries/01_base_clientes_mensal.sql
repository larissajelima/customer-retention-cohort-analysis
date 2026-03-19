-- Objetivo: identificar clientes ativos por mês
-- Granularidade: cliente por mês

SELECT DISTINCT
    cliente_id,
    DATE_TRUNC('month', data_pedido) AS mes_compra
FROM pedidos
ORDER BY cliente_id, mes_compra;