with source as (
    SELECT * from {{source('RAW','purchase_order_details')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source