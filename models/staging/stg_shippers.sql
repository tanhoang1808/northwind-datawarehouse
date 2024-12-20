with source as (
    SELECT * from {{source('RAW','shippers')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source