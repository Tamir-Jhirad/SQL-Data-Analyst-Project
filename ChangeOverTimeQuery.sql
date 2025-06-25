SELECT YEAR(order_date) as order_year,Month(order_date) as order_month , SUM(sales_amount) as total_sales, Count(DISTINCT customer_key) as total_customers, SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),Month(order_date)
ORDER BY YEAR(order_date),Month(order_date)


SELECT DATETRUNC(MONTH,order_date) as order_date , SUM(sales_amount) as total_sales, Count(DISTINCT customer_key) as total_customers, SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)