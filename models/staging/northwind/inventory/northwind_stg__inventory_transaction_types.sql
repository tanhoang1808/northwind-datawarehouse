WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'inventory_transaction_types'
	)}}
), unique_source AS
(
	SELECT  
	id as transaction_types_id,
	type_name
	       ,ROW_NUMBER() over(PARTITION BY id,type_name ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude row_number

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1