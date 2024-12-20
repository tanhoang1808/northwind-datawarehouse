with source as (
    SELECT * from {{source('RAW','privileges')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source