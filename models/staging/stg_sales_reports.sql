with source as (
    SELECT * from {{source('RAW','sales_reports')}}
),

unique_source as (
    select *,
    current_timestamp() as insertion_timestamp,
    row_number() over(partition by group_by order by group_by) as row_number
    from source
    
)


select 
* exclude row_number,
from unique_source
where row_number = 1