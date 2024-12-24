{{
  config(
    materialized = 'incremental',
    on_schema_change = 'fail'
    )
}}

with source as (
    select 
    c.customer_id,
    e.employee_id,
    po.purchase_order_id,
    p.product_id,
    p.product_name,
    p.product_code,
    pod.quantity,
    pod.unit_cost,
    pod.date_received,
    pod.posted_to_inventory,
    s.supplier_id,
    po.created_by,
    po.submitted_date,
    po.creation_date,
    po.status_id,
    po.expected_date,
    po.shipping_fee,
    po.taxes,
    po.payment_date,
    po.payment_amount,
    po.payment_method,
    po.approved_by,
    po.approved_date,
    po.submitted_by
    FROM {{ref('northwind_stg__purchase_orders')}} po
    LEFT JOIN {{ref('northwind_stg__purchase_order_details')}} pod
    ON pod.purchase_order_id = po.purchase_order_id
    LEFT JOIN {{ref('northwind_stg__products')}} p
    ON p.product_id = pod.product_id
    LEFT JOIN {{ref('northwind_stg__suppliers')}} s
    ON s.supplier_id = p.supplier_id
    LEFT JOIN {{ref('northwind_stg__order_details')}} od
    ON od.product_id = p.product_id
    LEFT JOIN {{ref('northwind_stg__orders')}} o
    ON o.order_id = od.order_id
    LEFT JOIN {{ref('northwind_stg__customer')}} c
    ON c.customer_id = o.customer_id
    LEFT JOIN {{ref('northwind_stg__employees')}} e
    ON e.employee_id = o.employee_id

    
)

select 
*
from source
where 
{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    creation_date >= '{{ var("start_date") }}'
    AND creation_date < '{{ var("end_date") }}'
  {% else %}
    creation_date > (SELECT MAX(creation_date) FROM {{ this }})
  {% endif %}
{% else %}
  1=1
{% endif %}