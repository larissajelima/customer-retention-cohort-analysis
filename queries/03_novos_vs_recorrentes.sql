-- Objetivo: classificar clientes como novos ou recorrentes por mês

WITH mes_compra AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes_compra
    FROM pedidos
),
primeira_compra AS (
    SELECT 
        cliente_id,
        DATE_TRUNC('month', MIN(data_pedido)) AS primeira_compra
    FROM pedidos
    GROUP BY cliente_id
),
tipo_cliente AS (
    SELECT
        m.cliente_id,
        m.mes_compra,
        p.primeira_compra,
        CASE 
            WHEN m.mes_compra = p.primeira_compra THEN 'novo'
            ELSE 'recorrente'
        END AS tipo_cliente
    FROM mes_compra m
    JOIN primeira_compra p
        ON m.cliente_id = p.cliente_id
)

SELECT 
    mes_compra,
    SUM(CASE WHEN tipo_cliente = 'novo' THEN 1 ELSE 0 END) AS clientes_novos,
    SUM(CASE WHEN tipo_cliente = 'recorrente' THEN 1 ELSE 0 END) AS clientes_recorrentes
FROM tipo_cliente
GROUP BY mes_compra
ORDER BY mes_compra;