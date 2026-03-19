CREATE OR REPLACE VIEW vw_cohort_retencao AS
WITH primeira_compra AS (
    SELECT
        cliente_id,
        DATE_TRUNC('month', MIN(data_pedido)) AS cohort_mes
    FROM pedidos
    GROUP BY cliente_id
),
mes_cliente AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes_compra
    FROM pedidos
),
base_cohort AS (
    SELECT
        mc.cliente_id,
        pc.cohort_mes,
        mc.mes_compra,
        (
            EXTRACT(YEAR FROM mc.mes_compra) * 12 + EXTRACT(MONTH FROM mc.mes_compra)
        ) - (
            EXTRACT(YEAR FROM pc.cohort_mes) * 12 + EXTRACT(MONTH FROM pc.cohort_mes)
        ) AS indice_mes
    FROM mes_cliente mc
    JOIN primeira_compra pc
        ON mc.cliente_id = pc.cliente_id
),
cohort_size AS (
    SELECT
        cohort_mes,
        COUNT(DISTINCT cliente_id) AS total_clientes
    FROM primeira_compra
    GROUP BY cohort_mes
),
retencao_cohort AS (
    SELECT
        cohort_mes,
        indice_mes,
        COUNT(DISTINCT cliente_id) AS clientes_ativos
    FROM base_cohort
    GROUP BY cohort_mes, indice_mes
)
SELECT
    rc.cohort_mes,
    rc.indice_mes,
    cs.total_clientes,
    rc.clientes_ativos,
    ROUND(rc.clientes_ativos * 100.0 / cs.total_clientes, 2) AS taxa_retencao_pct
FROM retencao_cohort rc
JOIN cohort_size cs
    ON rc.cohort_mes = cs.cohort_mes
ORDER BY rc.cohort_mes, rc.indice_mes;