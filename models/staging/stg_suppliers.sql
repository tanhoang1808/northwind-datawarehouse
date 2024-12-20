with source as (
    SELECT * from {{source('RAW','suppliers')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source