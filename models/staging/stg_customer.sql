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
    cast(notes as varchar) as web_page,
    cast(notes as varchar) as notes,
    cast(notes as varchar) as attachments
    from {{source('RAW','customer')}}
),

unique_source as (
    select
    customer_id,
    company_name,
    last_name,
    first_name,
    email,
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
    CASE 
        WHEN web_page is null 
            THEN 'No website'
        ELSE web_page
    END as web_page_information,
    CASE 
        WHEN notes is null 
            THEN 'No Notes'
        ELSE notes
    END as Notes_information,
    CASE 
        WHEN attachments is null 
            THEN 'No attachments'
        ELSE attachments
    END as attachments_information,

    row_number() over(partition by customer_id order by customer_id) as row_number
    from source
)

select 
* 
exclude row_number
from unique_source
where row_number = 1