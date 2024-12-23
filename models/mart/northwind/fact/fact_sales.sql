with source as (
    select
    o.order_id,
    p.product_id,
    c.customer_id,
    e.employee_id,
    od.quantity,
    od.unit_price,
    od.discount,
    od.status_id,
    od.date_allocated,
    pod.purchase_order_id,
    pod.inventory_id,
    o.order_date,
    o.shipped_date,
    o.paid_date
    FROM {{ref('northwind_stg__order_details')}} od
    JOIN {{ref('northwind_stg__orders')}} o
    ON o.order_id = od.order_id
    JOIN {{ref('northwind_stg__products')}} p
    LEFT JOIN {{ref('northwind_stg__purchase_order_details')}} pod
    ON pod.product_id = od.product_id
    LEFT JOIN {{ref('northwind_stg__purchase_orders')}} po
    ON pod.purchase_order_id = po.purchase_order_id
    LEFT JOIN {{ref('northwind_stg__employees')}} e
    ON e.employee_id  = o.employee_id
    LEFT JOIN {{ref('northwind_stg__customer')}} c
    ON c.customer_id = o.customer_id
)

select * from source


