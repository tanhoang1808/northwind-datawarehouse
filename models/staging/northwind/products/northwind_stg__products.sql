WITH source AS
(
	SELECT  *
	FROM {{source
	('NORTHWIND_RAW', 'products'
	)}}
), unique_source AS
(
	SELECT  id AS product_id
	       ,product_code
	       ,product_name
	       ,description
	       ,standard_cost
	       ,list_price
	       ,reorder_level
	       ,target_level
	       ,quantity_per_unit
	       ,discontinued
	       ,minimum_reorder_quantity
	       ,category
		   ,supplier_ids as supplier_id
	       ,ROW_NUMBER() over(PARTITION BY product_id,product_code,product_name ORDER BY  product_id) AS row_number

	       ,current_timestamp()                                                                       AS insertion_timestamp
	FROM source
)
SELECT  * exclude row_number
       ,
FROM unique_source
WHERE ROW_NUMBER = 1