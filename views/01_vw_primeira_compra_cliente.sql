CREATE OR REPLACE VIEW vw_retencao_mensal AS
WITH mes_cliente AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes
    FROM pedidos
),
cliente_com_lag AS (
    SELECT
        cliente_id,
        mes,
        LAG(mes) OVER (
            PARTITION BY cliente_id
            ORDER BY mes
        ) AS mes_anterior
    FROM mes_cliente
),
retencao AS (
    SELECT
        mes,
        COUNT(*) AS clientes_mes_atual,
        SUM(
            CASE
                WHEN mes_anterior = mes - INTERVAL '1 month' THEN 1
                ELSE 0
            END
        ) AS clientes_retidos
    FROM cliente_com_lag
    GROUP BY mes
)
SELECT
    mes,
    clientes_mes_atual,
    clientes_retidos,
    ROUND(clientes_retidos * 100.0 / clientes_mes_atual, 2) AS taxa_retencao_pct
FROM retencao
ORDER BY mes;