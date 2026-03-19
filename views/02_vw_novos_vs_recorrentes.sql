CREATE OR REPLACE VIEW vw_primeira_compra_cliente AS
SELECT
    cliente_id,
    DATE_TRUNC('month', MIN(data_pedido)) AS primeiro_mes_compra
FROM pedidos
GROUP BY cliente_id;