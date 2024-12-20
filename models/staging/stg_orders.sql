with source as (
    SELECT * from {{source('RAW','orders')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source