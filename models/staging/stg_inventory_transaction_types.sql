with source as (
    SELECT * from {{source('RAW','inventory_transaction_types')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source