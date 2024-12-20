with source as (
    SELECT * from {{source('RAW','employee_privileges')}}
)


select 
*,

current_timestamp() as insertion_timestamp 
from source