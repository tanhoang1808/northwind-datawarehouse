with source as (
    SELECT * from {{source('RAW','products')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source