WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'inventory_transactions'
	)}}
), unique_source AS
(
	SELECT  *
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude ROW_NUMBER

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1