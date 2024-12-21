with source as (
    SELECT * from {{source('RAW','purchase_order_details')}}
),


unique_source as (
    select *,
    CASE
        WHEN date_received is null THEN 0
        ElSE 1 
    end as is_has_date_received,
    row_number() over(partition by 
    id,
    purchase_order_id,
    product_id 
    order by 
    id
    ) as row_number,
    current_timestamp() as insertion_timestamp 
    from source
)


select 
* exclude row_number
from unique_source
where row_number = 1 