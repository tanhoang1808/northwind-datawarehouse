with source as (
    SELECT 
    id as product_id,
    product_code,
    product_name,
    description,
    supplier_company,
    standard_cost,
    list_price,
    reorder_level,
    target_level,
    quantity_per_unit,
    discontinued,
    minimum_reorder_quantity,
    category,
    attachments
     from {{source('RAW','products')}}
)


select 
    *,
    row_number() over(partition by 
    product_id,
    product_code,
    order by product_id) as row_number

current_timestamp() as insertion_timestamp 
from source