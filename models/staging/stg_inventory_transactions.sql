with source as (
    SELECT * from {{source('RAW','inventory_transactions')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source