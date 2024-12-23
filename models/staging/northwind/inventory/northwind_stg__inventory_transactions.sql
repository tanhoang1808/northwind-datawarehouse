WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'inventory_transactions'
	)}}
), 
unique_source AS
(
	SELECT  
	id as inventory_transactions_id,
	transaction_type,
	transaction_created_date,
	transaction_modified_date,
	product_id,
	quantity,
	purchase_order_id,
	customer_order_id,
	comments
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude row_number

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1