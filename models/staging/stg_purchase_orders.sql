with source as (
    SELECT * from {{source('RAW','purchase_orders')}}
),

unique_source as (
    select 
    id,
    supplier_id,
    created_by,
    submitted_date,
    creation_date,
    status_id,
    expected_date,
    shipping_fee,
    taxes,
    payment_amount,
    CASE
        WHEN payment_method is null then 'Anonymous'
        ELSE payment_method
    END AS payment_method,
    approved_by,
    approved_date,
    submitted_by,
    current_timestamp() as insertion_timestamp,
    row_number() over(partition by 
    id,
    supplier_id 
    order by
    id) as row_number
    from source
)

select *  exclude row_number from unique_source
where row_number = 1