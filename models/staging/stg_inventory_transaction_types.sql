with source as (
    SELECT * from {{source('RAW','inventory_transaction_types')}}
),


unique_source as (
    select *,
    row_number() over(partition by id,type_name order by id) as row_number
    from source
)


select 
* exclude row_number,
current_timestamp() as insertion_timestamp
from unique_source
where row_number = 1