SELECT
customer_first_name,
customer_last_name,
AVG(standard_cost),
SUM(quantity),
SUM(UNIT_COST * quantity) as total_spend
FROM
{{ref('customer_reporting')}}
GROUP BY customer_last_name,customer_first_name,creation_date