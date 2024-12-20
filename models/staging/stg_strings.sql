with source as (
    SELECT * from {{source('RAW','strings')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source