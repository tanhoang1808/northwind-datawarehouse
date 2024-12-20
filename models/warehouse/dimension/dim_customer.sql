with source as (
    select
    id as customer_id,
    company as company_name,
    last_name,
    first_name,
    email_address as email,
    job_title ,
    business_phone,
    home_phone,
    mobile_phone,
    fax_number,
    address,
    city,
    state_province,
    zip_postal_code,
    country_region,
    web_page
    from {{ref("stg_customer")}}
),

unique_source as (
    select *,
    row_number() over(partition by customer_id order by customer_id) as row_number
    from source
)

select 
* 
exclude row_number
from unique_source
where row_number = 1
