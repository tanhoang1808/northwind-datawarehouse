WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'order_details'
	)}}
), unique_source AS
(
	SELECT  id
	       ,order_id
	       ,product_id
	       ,quantity
	       ,unit_price
	       ,discount
	       ,status_id
	       ,date_allocated
	       ,purchase_order_id
	       ,inventory_id
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  id
       ,order_id
       ,product_id
       ,quantity
       ,unit_price
       ,discount
       ,status_id
       ,date_allocated
       ,purchase_order_id
       ,CASE WHEN purchase_order_id::varchar is null THEN 'Pending Order'  ELSE 'Order Purchased' END AS purchase_order_string
       ,inventory_id

       ,current_timestamp()                                                                           AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1