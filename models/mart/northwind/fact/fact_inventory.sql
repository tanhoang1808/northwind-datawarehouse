with source as (
    select
    it.transaction_type,
    it.transaction_created_date,
    it.transaction_modified_date,
    p.product_id,
    pod.quantity,
    it.purchase_order_id as inventory_purchase_order_id,
    po.purchase_order_id as purchase_order_id,
    it.customer_order_id,
    it.comments
    FROM {{ref('northwind_stg__inventory_transactions')}} it
    LEFT JOIN {{ref('northwind_stg__products')}} p
    ON p.product_id = it.product_id
    LEFT JOIN {{ref('northwind_stg__inventory_transaction_types')}} itp
    ON it.transaction_type = itp.type_name
    LEFT JOIN {{ref('northwind_stg__purchase_orders')}} po
    ON po.purchase_order_id = it.purchase_order_id
    LEFT JOIN {{ref('northwind_stg__purchase_order_details')}} pod
    ON pod.purchase_order_id = po.purchase_order_id
)
select * from source