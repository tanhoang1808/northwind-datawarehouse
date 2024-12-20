with source as (
    SELECT * from {{source('RAW','orders_status')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source