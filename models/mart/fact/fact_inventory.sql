{{
  config(
    materialized = 'incremental',
    on_schema_change = 'fail'
    )
}}

with source as (
    select
    itp.type_name,
    it.transaction_created_date,
    it.transaction_modified_date,
    p.product_id,
    p.product_name,
    CASE
        WHEN pod.quantity IS NULL THEN 0
        ELSE pod.quantity 
    END as quantity,
    it.purchase_order_id as inventory_purchase_order_id,
    po.purchase_order_id as purchase_order_id,
    it.customer_order_id,
    CASE
        WHEN it.comments is NULL then 'No Comment'
        ELSE it.comments
    END as comments,
    FROM {{ref('northwind_stg__inventory_transactions')}} it
    LEFT JOIN {{ref('northwind_stg__products')}} p
    ON p.product_id = it.product_id
    LEFT JOIN {{ref('northwind_stg__inventory_transaction_types')}} itp
    ON it.transaction_type = itp.inventory_transaction_types_id
    LEFT JOIN {{ref('northwind_stg__purchase_orders')}} po
    ON po.purchase_order_id = it.purchase_order_id
    LEFT JOIN {{ref('northwind_stg__purchase_order_details')}} pod
    ON pod.purchase_order_id = po.purchase_order_id
)

select 
*
from source
where 
{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    transaction_created_date >= '{{ var("start_date") }}'
    AND transaction_created_date < '{{ var("end_date") }}'
  {% else %}
    paid_date > (SELECT MAX(transaction_created_date) FROM {{ this }})
  {% endif %}
{% else %}
  1=1
{% endif %}