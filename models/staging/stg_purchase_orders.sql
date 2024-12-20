with source as (
    SELECT * from {{source('RAW','purchase_orders')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source