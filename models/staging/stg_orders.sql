with source as (
    SELECT * from {{source('RAW','orders')}}
),

unique_source as (
    select 
    id,
    employee_id,
    customer_id,
    order_date,
    shipped_date,
    shipper_id,
    ship_name,
    ship_address,
    ship_city,
    ship_state_province,
    ship_zip_postal_code,
    ship_country_region,
    shipping_fee,
    taxes,
    payment_type,
    paid_date,
    CASE 
        WHEN 
            paid_date is null THEN 0
        ELSE 1 
    END AS is_paid,
    tax_rate,
    tax_status_id,
    status_id,
current_timestamp() as insertion_timestamp,
row_number() over(partition by id  order by id) as row_number
from source
)


select 
* exclude row_number
from unique_source
where row_number = 1 
