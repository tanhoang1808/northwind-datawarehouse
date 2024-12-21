WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'purchase_order_status'
	)}}
), unique_source AS
(
	SELECT  *

	       ,current_timestamp()AS insertion_timestamp
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  *
FROM unique_source
WHERE ROW_NUMBER = 1