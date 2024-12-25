{{
  config(
    materialized = 'table'
    )
}}


with source as (
    SELECT 
    c.customer_id,
    c.company_name,
    c.last_name,
    c.first_name,
    c.email,
    c.job_title,
    c.business_phone::varchar as business_phone,
    c.home_phone::varchar as home_phone,
    c.mobile_phone::varchar as mobile_phone,
    c.fax_number,
    c.address,
    c.city,
    c.state_province,
    c.zip_postal_code,
    c.country_region,
    c.web_page_information,
    c.Notes_information,
    c.attachments_information
     FROM {{ ref('northwind_stg__customer') }} c
)

select
*
FROM
source 


