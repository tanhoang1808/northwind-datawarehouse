with source as (
    SELECT * from {{source('RAW','purchase_order_status')}}
),
unique_source as (
    select *,
    current_timestamp() as insertion_timestamp,
    row_number() over(partition by id order by id) as row_number
    from source
)


select 
*
from unique_source
where row_number = 1