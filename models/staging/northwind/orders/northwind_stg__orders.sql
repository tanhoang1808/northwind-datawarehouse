WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'orders'
	)}}
), unique_source AS
(
	SELECT  id as order_id
	       ,employee_id
	       ,customer_id
	       ,order_date
	       ,shipped_date
	       ,shipper_id
	       ,ship_name
	       ,ship_address
	       ,ship_city
	       ,ship_state_province
	       ,ship_zip_postal_code
	       ,ship_country_region
	       ,shipping_fee
	       ,taxes
	       ,payment_type
	       ,paid_date
	       ,CASE WHEN paid_date is null THEN 0  ELSE 1 END  AS is_paid
	       ,tax_rate
	       ,tax_status_id
	       ,status_id

	       ,current_timestamp() AS insertion_timestamp
	       ,ROW_NUMBER() over(PARTITION BY id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude row_number
FROM unique_source
WHERE ROW_NUMBER = 1 