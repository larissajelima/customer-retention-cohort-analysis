CREATE OR REPLACE VIEW vw_novos_vs_recorrentes AS
WITH mes_cliente AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes
    FROM pedidos
)
SELECT
    mc.mes,
    COUNT(CASE WHEN mc.mes = pc.primeiro_mes_compra THEN 1 END) AS clientes_novos,
    COUNT(CASE WHEN mc.mes > pc.primeiro_mes_compra THEN 1 END) AS clientes_recorrentes,
    COUNT(*) AS total_clientes
FROM mes_cliente mc
JOIN vw_primeira_compra_cliente pc
    ON mc.cliente_id = pc.cliente_id
GROUP BY mc.mes
ORDER BY mc.mes;