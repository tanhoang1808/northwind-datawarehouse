WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'inventory_transaction_types'
	)}}
), unique_source AS
(
	SELECT  *
	       ,ROW_NUMBER() over(PARTITION BY id,type_name ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude ROW_NUMBER

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1