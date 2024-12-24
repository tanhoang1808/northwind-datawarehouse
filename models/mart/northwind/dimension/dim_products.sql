{{{{
  config(
    materialized = 'table',
    )
}}}}




with source as (
    select
    p.supplier_id,
    p.product_id,
    p.product_code,
    p.product_name,
    p.description,
    s.company,
    p.standard_cost,
    p.list_price,
    p.reorder_level,
    p.target_level,
    p.quantity_per_unit,
    p.discontinued,
    p.minimum_reorder_quantity,
    p.category
    FROM {{ref('northwind_stg__products')}} p
    JOIN {{ref('northwind_stg__suppliers')}} s
    ON s.supplier_id = p.supplier_id
)

select * from source