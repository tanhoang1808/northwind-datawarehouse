with source as (
    SELECT * from {{source('RAW','sales_reports')}}
)


select 
*,
current_timestamp() as insertion_timestamp 
from source