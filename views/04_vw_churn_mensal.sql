CREATE OR REPLACE VIEW vw_churn_mensal AS
WITH mes_cliente AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes
    FROM pedidos
),
base AS (
    SELECT
        a.cliente_id,
        a.mes,
        CASE
            WHEN b.cliente_id IS NULL THEN 1
            ELSE 0
        END AS churnou
    FROM mes_cliente a
    LEFT JOIN mes_cliente b
        ON a.cliente_id = b.cliente_id
       AND b.mes = a.mes + INTERVAL '1 month'
),
churn_mensal AS (
    SELECT
        mes,
        COUNT(*) AS clientes_mes,
        SUM(churnou) AS clientes_churn
    FROM base
    GROUP BY mes
)
SELECT
    mes,
    clientes_mes,
    clientes_churn,
    ROUND(clientes_churn * 100.0 / clientes_mes, 2) AS taxa_churn_pct
FROM churn_mensal
ORDER BY mes;