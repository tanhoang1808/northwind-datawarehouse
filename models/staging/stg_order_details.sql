with source as (
    SELECT * from {{source('RAW','order_details')}}
),

unique_source as (
    select
    id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    status_id,
    date_allocated,
    purchase_order_id,
    inventory_id,
    row_number() over(partition by id order by id) as row_number
    from source
)


select 
    id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    status_id,
    date_allocated,
    purchase_order_id,
    CASE
        WHEN
            purchase_order_id::varchar is null 
            THEN
            'Pending Order'
        ElSE 
            'Order Purchased'
    END AS purchase_order_string,
    inventory_id,
current_timestamp() as insertion_timestamp 
from unique_source
where row_number = 1