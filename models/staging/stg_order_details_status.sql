with source as (
    SELECT * from {{source('RAW','order_details_status')}}
)

select 
*,
current_timestamp() as insertion_timestamp 
from source