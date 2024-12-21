with source as (
    SELECT * from {{source('RAW','employee_privileges')}}
),



 unique_source as (
    select *,
    row_number() over(partition by employee_id, privilege_id order by employee_id) as row_number
    from source
)

select 
* exclude row_number,
current_timestamp() as insertion_timestamp 
from unique_source
where row_number = 1