-- Objetivo: calcular retenção por cohort de clientes

WITH primeira_compra AS (
    SELECT 
        cliente_id,
        DATE_TRUNC('month', MIN(data_pedido)) AS cohort_mes
    FROM pedidos
    GROUP BY cliente_id
),
mes_compra AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes_compra
    FROM pedidos
),
base_cohort AS (
    SELECT
        m.cliente_id,
        pc.cohort_mes,
        m.mes_compra
    FROM mes_compra m
    JOIN primeira_compra pc
        ON m.cliente_id = pc.cliente_id
),
base_indice AS (
    SELECT
        cliente_id,
        cohort_mes,
        mes_compra,
        (EXTRACT(YEAR FROM mes_compra) - EXTRACT(YEAR FROM cohort_mes)) * 12
        +
        (EXTRACT(MONTH FROM mes_compra) - EXTRACT(MONTH FROM cohort_mes)) AS mes_indice
    FROM base_cohort
),
clientes_ativos AS (
    SELECT 
        cohort_mes,
        mes_indice,
        COUNT(cliente_id) AS clientes_ativos
    FROM base_indice
    GROUP BY cohort_mes, mes_indice
),
cohort_zero AS (
    SELECT 
        cohort_mes,
        clientes_ativos AS clientes_base_cohort
    FROM clientes_ativos
    WHERE mes_indice = 0
)

SELECT
    ca.cohort_mes,
    ca.mes_indice,
    ca.clientes_ativos,
    cz.clientes_base_cohort,
    ROUND(ca.clientes_ativos * 1.0 / cz.clientes_base_cohort, 2) AS taxa_retencao_cohort
FROM clientes_ativos ca
JOIN cohort_zero cz
    ON ca.cohort_mes = cz.cohort_mes
ORDER BY ca.cohort_mes, ca.mes_indice;