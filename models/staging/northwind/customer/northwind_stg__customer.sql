WITH source AS
(
	SELECT  id AS customer_id
	       ,company AS company_name
	       ,last_name
	       ,first_name
	       ,email_address AS email
	       ,job_title
	       ,business_phone
	       ,home_phone
	       ,mobile_phone
	       ,fax_number
	       ,address
	       ,city
	       ,state_province
	       ,zip_postal_code
	       ,country_region
	       ,cast(notes AS varchar) AS web_page
	       ,cast(notes AS varchar) AS notes
	       ,cast(notes AS varchar) AS attachments
	FROM {{source
	('RAW', 'customer'
	)}}
), unique_source AS
(
	SELECT  customer_id
	       ,company_name
	       ,last_name
	       ,first_name
	       ,email
	       ,job_title
	       ,business_phone
	       ,home_phone
	       ,mobile_phone
	       ,fax_number
	       ,address
	       ,city
	       ,state_province
	       ,zip_postal_code
	       ,country_region
	       ,CASE WHEN web_page is null THEN 'No website'  ELSE web_page END           AS web_page_information
	       ,CASE WHEN notes is null THEN 'No Notes'  ELSE notes END                   AS Notes_information
	       ,CASE WHEN attachments is null THEN 'No attachments'  ELSE attachments END AS attachments_information
	       ,ROW_NUMBER() over(PARTITION BY customer_id ORDER BY  customer_id)         AS row_number
	FROM source
)
SELECT  * exclude row_number
FROM unique_source
WHERE ROW_NUMBER = 1