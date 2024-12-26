WITH source AS
(
	SELECT 
	id as status_id,
	status
	FROM {{source
	('NORTHWIND_RAW', 'purchase_order_status'
	)}}
), unique_source AS
(
	SELECT  *

	       ,current_timestamp()AS insertion_timestamp
	       ,ROW_NUMBER() over(PARTITION BY status_id ORDER BY  status_id) AS row_number
	FROM source
)
SELECT  *
FROM unique_source
WHERE ROW_NUMBER = 1