WITH source AS (
    SELECT *
    FROM {{ source('NORTHWIND_RAW', 'products') }}
), 
unique_source AS (
    SELECT 
        id AS product_id,
        product_code,
        product_name,
        description,
        standard_cost,
        list_price,
        reorder_level,
        target_level,
        quantity_per_unit,
        discontinued,
        minimum_reorder_quantity,
        category,
        flattened.value::string AS supplier_id, -- Kết quả tách giá trị từ cột supplier_ids
        ROW_NUMBER() OVER (PARTITION BY id, product_code, product_name ORDER BY id) AS row_number,
        current_timestamp() AS insertion_timestamp
    FROM source,
    {{ split_by_delimiter('supplier_ids', ';') }} AS flattened
)
SELECT * EXCLUDE row_number
FROM unique_source
WHERE row_number = 1
