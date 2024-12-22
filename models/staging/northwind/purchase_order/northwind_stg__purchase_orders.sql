WITH source AS
(
	SELECT  *
	FROM {{source
	('RAW', 'purchase_orders'
	)}}
), unique_source AS
(
	SELECT  id AS purchase_order_id
	       ,supplier_id
	       ,created_by
	       ,submitted_date
	       ,creation_date
	       ,status_id
	       ,expected_date
	       ,shipping_fee
	       ,taxes
	       ,payment_amount
		   ,payment_date
	       ,CASE WHEN payment_method is null THEN 'Anonymous'  ELSE payment_method END AS payment_method
	       ,approved_by
	       ,approved_date
	       ,submitted_by
		
	       ,current_timestamp()  AS insertion_timestamp
	       ,ROW_NUMBER() over(PARTITION BY id,supplier_id ORDER BY  id) AS row_number
	FROM source
)
SELECT  * exclude row_number
FROM unique_source
WHERE ROW_NUMBER = 1