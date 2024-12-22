with source as (
    select
    product_id,
    product_code,
    product_name,
    description,
    s.company,
    standard_cost,
    list_price,
    reorder_level,
    target_level,
    quantity_per_unit,
    discontinued,
    minimum_reorder_quantity,
    category,
    
    FROM {{ref('northwind_stg__products')}} p
    JOIN  {{ref('northwind_stg__suppliers')}} s
    ON p.supplier_id = s.id
)

select * from source