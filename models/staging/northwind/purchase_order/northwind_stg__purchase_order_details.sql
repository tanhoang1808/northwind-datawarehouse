WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'purchase_order_details'
	)}}
), unique_source AS
(
	SELECT  *
	       ,CASE WHEN date_received is null THEN 0  ELSE 1 END AS is_has_date_received
	       ,ROW_NUMBER() over(PARTITION BY id,purchase_order_id,product_id ORDER BY  id ) AS row_number

	       ,current_timestamp() AS insertion_timestamp
	FROM source
)
SELECT  * exclude row_number
FROM unique_source
WHERE ROW_NUMBER = 1 