with source as (
    SELECT * from {{source('RAW','inventory_transactions')}}
),


unique_source as (
    select *,
    row_number() over(partition by id order by id) as row_number
    from source
)


select 
* exclude row_number
,
current_timestamp() as insertion_timestamp
from unique_source
where row_number = 1