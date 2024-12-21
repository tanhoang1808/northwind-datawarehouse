with source as (
    SELECT 
    *
     from {{source('RAW','products')}}
),

unique_source as (
    select
    id as product_id,
    product_code,
    product_name,
    description,
    standard_cost,
    list_price,
    reorder_level,
    target_level,
    quantity_per_unit,
    discontinued,
    minimum_reorder_quantity,
    category,
    row_number() over(partition by 
    product_id,
    product_code,
    product_name
    order by product_id) as row_number,
    current_timestamp() as insertion_timestamp 
    from source
)

    select 
    * exclude row_number,
    from unique_source
    where row_number = 1