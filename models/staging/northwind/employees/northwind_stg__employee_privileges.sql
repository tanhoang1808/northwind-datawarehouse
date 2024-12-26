WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'employee_privileges'
	)}}
), unique_source AS
(
	SELECT  *
	       ,ROW_NUMBER() over(PARTITION BY employee_id,privilege_id ORDER BY  employee_id) AS row_number
	FROM source
)
SELECT  * exclude ROW_NUMBER 

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE ROW_NUMBER = 1