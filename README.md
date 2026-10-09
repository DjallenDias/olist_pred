# Previsão de Atrasos em Entregas | Olist

Projeto de **Engenharia de Dados e Machine Learning aplicado à logística**, utilizando dados públicos do e-commerce brasileiro Olist. O objetivo é investigar fatores associados a atrasos e desenvolver um modelo que **priorize pedidos com maior risco de entrega após o prazo estimado**.

> **Status:** pipeline analítico, dashboard e experimentos de modelagem concluídos. O modelo é um protótipo analítico, não um sistema validado para produção.

## Visão geral

O projeto combina:

- **PostgreSQL:** ingestão, limpeza, integração e preparação dos dados em camadas Raw, Silver e Gold.
- **Metabase:** dashboard interativo para análise operacional de entregas.
- **Python e scikit-learn:** EDA técnico, preparação de features, validação temporal e comparação de classificadores.

**Fonte dos dados:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

## Arquitetura

```text
CSVs da Olist
    │
    ▼
PostgreSQL
    ├── raw     → ingestão dos arquivos originais
    ├── silver  → padronização, deduplicação e integridade
    └── gold    → tabela analítica por pedido
                    │
                    ├── Metabase → dashboard operacional
                    │
                    └── Python → EDA técnico
                                  │
                                  ▼
                            Machine Learning
                                  │
                       Validação e teste temporal
```

## Tecnologias

| Etapa | Ferramentas |
|---|---|
| Banco de dados e transformações | PostgreSQL, SQL, DBeaver |
| Análise e visualização | Python, pandas, NumPy, Matplotlib, Seaborn, Metabase |
| Machine Learning | scikit-learn |
| Integração Python–PostgreSQL | SQLAlchemy, python-dotenv |
| Persistência do modelo | joblib |

## Engenharia de dados e features

O pipeline integra informações de pedidos, itens, produtos, vendedores, clientes, localização, pagamentos e categorias. Entre as variáveis utilizadas estão:

- **Prazo e tempo:** mês, dia da semana e hora da compra, tempo até aprovação e prazo estimado de entrega.
- **Características do pedido:** quantidade de itens, produtos e vendedores distintos, preço, frete, peso e volume.
- **Logística:** distância aproximada entre vendedor e cliente e tipo de trajeto por estado.
- **Pagamento e produto:** quantidade de pagamentos, tipos de pagamento, parcelas e categoria principal.

A previsão foi definida para ocorrer **após a aprovação do pedido**, momento em que o tempo de aprovação já é conhecido.

## Dashboard operacional

O dashboard no Metabase foi dividido em duas páginas, **Inicial** e **Detalhado**, para apresentar indicadores gerais e análises segmentadas de atraso.

![img](/assets/image1.png)
![img](/assets/image2.png)
![img](/assets/image3.png)
![img](/assets/image4.png)

## Metodologia de Machine Learning

O problema foi tratado como **classificação binária desbalanceada**. No conjunto completo, aproximadamente **8,11%** dos pedidos apresentaram atraso.

## Referências

- [Dataset público Olist no Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- [Documentação do scikit-learn](https://scikit-learn.org/stable/)
- [Documentação do Metabase](https://www.metabase.com/docs/latest/)

---

*Projeto desenvolvido para estudo e portfólio em Engenharia de Dados, Ciência de Dados e Machine Learning aplicado à logística.*