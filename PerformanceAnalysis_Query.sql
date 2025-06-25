/* Analyze the yearly performance of products by comapring their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS (
SELECT
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales 
FROM gold.fact_sales as f
Left JOIN gold.dim_products as p
ON f.product_key=p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(f.order_date), p.product_name

)

SELECT
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) as avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)>0 THEN 'Above avg'
WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)<0 THEN 'Below Avg'
ELSE 'Avg'
END as avg_change ,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)>0 THEN 'Increase'
WHEN current_sales -LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)<0 THEN 'Decrease'
ELSE 'No Change'
END as avg_change
FROM yearly_product_sales
ORDER BY product_name, order_year