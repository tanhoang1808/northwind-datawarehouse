WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'sales_reports'
	)}}
), unique_source AS
(
	SELECT  *

	       ,current_timestamp() AS insertion_timestamp
	       ,ROW_NUMBER() over(PARTITION BY group_by ORDER BY  group_by) AS row_number
	FROM source
)
SELECT  * exclude row_number
       ,
FROM unique_source
WHERE ROW_NUMBER = 1