WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'order_details_status'
	)}}
), unique_source AS
(
	SELECT  *
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude row_number

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1