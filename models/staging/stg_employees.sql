with source as (
    SELECT * from {{source('RAW','employees')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source