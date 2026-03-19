#  Análise de Retenção de Clientes

## 📊 Dashboard

![Dashboard](assets/dashboard.png)

Este projeto tem como objetivo analisar o comportamento de retenção de clientes ao longo do tempo, identificando padrões de recompra e oportunidades de melhoria na fidelização.

---

## 🎯 Objetivo

Avaliar a retenção de clientes mês a mês, distinguindo entre novos e recorrentes, além de identificar padrões de churn através de análise de cohort.

---

## 📌 Principais Insights

- A taxa de retenção estabiliza em aproximadamente **50%**, indicando que metade dos clientes retorna no mês seguinte.
- O crescimento inicial da base é impulsionado por **novos clientes**, com baixa recorrência no início.
- A análise de cohort evidencia uma **queda acentuada após o primeiro ciclo de retenção**, sugerindo desafios na fidelização.
- O volume de dados é limitado, podendo impactar a robustez das conclusões.

💡 **Recomendação:** implementar estratégias de retenção como campanhas de CRM e incentivos à recompra.

---

## 📊 Dashboard

O dashboard foi desenvolvido no Power BI e apresenta:

- 📈 Taxa de retenção mensal
- 📊 Comparação entre clientes novos e recorrentes
- 🔥 Análise de cohort (retenção ao longo do tempo)
- 🧠 Insights estratégicos

---

## 🛠️ Tecnologias Utilizadas

- SQL (PostgreSQL)
- Power BI
- Modelagem de dados
- GitHub

---

## 🗂️ Estrutura do Projeto
```
customer-retention-cohort-analysis/
│
├── data/
│ ├── raw/
│      └── insert_data.sql
│
├── schema/
│ └── create_tables.sql
│
├── queries/
│ ├── 01_base_clientes_mensal.sql
│ ├── 02_primeira_compra_clientes.sql
│ ├── 03_novos_vs_recorrentes.sql
│ ├── 04_retencao_mensal.sql
│ ├── 05_churn_mensal.sql
│ └── 06_cohort_retencao.sql
│
├── dashboard/
│ └── powerbi_dashboard.pbix
│
└── insights/
└── principais_insights.md
```
---

## 🔄 Processo de Análise

1. Criação das tabelas e carga de dados
2. Construção de queries para análise de comportamento
3. Cálculo de métricas:
   - Retenção
   - Churn
   - Clientes novos vs recorrentes
4. Construção de análise de cohort
5. Visualização no Power BI

---

## 📈 Métricas Analisadas

- Taxa de retenção mensal
- Taxa de churn
- Clientes novos vs recorrentes
- Retenção por cohort

---

## 🚀 Possíveis Melhorias

- Aumentar volume de dados para maior confiabilidade
- Incluir segmentação por perfil de cliente
- Analisar impacto de campanhas de marketing
- Criar previsões de churn (machine learning)

---

## 👩‍💻 Autor

Larissa Lima  
📍 Brasil  
💼 Em transição para Analista de BI

---
