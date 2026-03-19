-- Objetivo: calcular churn mensal de clientes

WITH mes_compra AS (
    SELECT DISTINCT
        cliente_id,
        DATE_TRUNC('month', data_pedido) AS mes_compra
    FROM pedidos
),
mes_anterior AS (
    SELECT
        *,
        LAG(mes_compra) OVER (PARTITION BY cliente_id ORDER BY mes_compra) AS mes_anterior
    FROM mes_compra
),
retencao AS (
    SELECT
        *,
        CASE 
            WHEN mes_anterior IS NULL THEN 'novo'
            WHEN mes_anterior = mes_compra - INTERVAL '1 month' THEN 'retido'
            ELSE 'nao_retido'
        END AS status_cliente
    FROM mes_anterior
),
mes_cliente AS (
    SELECT 
        mes_compra,
        COUNT(cliente_id) AS clientes_mes,
        SUM(CASE WHEN status_cliente = 'retido' THEN 1 ELSE 0 END) AS clientes_retidos
    FROM retencao
    GROUP BY mes_compra
),
base AS (
    SELECT
        mes_compra,
        clientes_mes,
        clientes_retidos,
        LAG(clientes_mes) OVER (ORDER BY mes_compra) AS clientes_mes_anterior
    FROM mes_cliente
)

SELECT 
    mes_compra,
    clientes_mes,
    clientes_retidos,
    clientes_mes_anterior,
    clientes_mes_anterior - clientes_retidos AS clientes_churn,
    CASE 
        WHEN clientes_mes_anterior IS NULL OR clientes_mes_anterior = 0 THEN NULL
        ELSE (clientes_mes_anterior - clientes_retidos) * 1.0 / clientes_mes_anterior
    END AS taxa_churn
FROM base
ORDER BY mes_compra;