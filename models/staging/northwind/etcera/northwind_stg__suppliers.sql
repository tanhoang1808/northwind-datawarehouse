WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'suppliers'
	)}}
), 
unique_source AS
(
	SELECT id AS supplier_id,
	company,
	last_name,
	first_name,
	email_address,
	job_title,
	business_phone,
	home_phone,
	mobile_phone,
	fax_number,
	address,
	city,
	state_province,
	zip_postal_code,
	country_region,
	web_page,
	notes,
	attachments,
	ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  *  exclude row_number
       ,current_timestamp() AS insertion_timestamp
FROM unique_source
where row_number = 1