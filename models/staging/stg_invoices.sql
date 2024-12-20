with source as (
    SELECT * from {{source('RAW','invoices')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source