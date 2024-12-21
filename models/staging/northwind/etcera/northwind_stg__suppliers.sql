WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'suppliers'
	)}}
), unique_source AS
(
	SELECT  *
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude(web_page,notes,attachments)

       ,current_timestamp() AS insertion_timestamp
FROM unique_source
WHERE id = 1