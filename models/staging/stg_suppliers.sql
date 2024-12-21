with source as (
    SELECT * from {{source('RAW','suppliers')}}
),

unique_source as (
    select *,
    row_number() over(partition by id order by id) as row_number
    from source
)


select 
* exclude(web_page,notes,attachments),
current_timestamp() as insertion_timestamp 
from unique_source
where id = 1