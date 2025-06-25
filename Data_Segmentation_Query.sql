/* Segement products into cost ranges and 
count how manyt products fall into each segment */


WITH product_segements AS(
SELECT 
product_key,
product_name,
cost,
Case WHEN cost < 100 Then 'Below 100'
     WHEN cost BETWEEN 100 AND 500 Then '100-150'
     WHEN cost BETWEEN 500 AND 1000 Then '500-1000'
     ELSE 'Above 1000' 
END cost_range

FROM gold.dim_products)

SELECT
cost_range,
COUNT (product_key) AS total_products
FROM product_segements
GROUP BY cost_range
ORDER BY total_products DESC


/* Group coustomers into three segments based on their spending behaviorL
 VIP - at least 12 months of history and spending more than 5000$
 Regular - at least 12 monthhs of history but spending 5000$ or less
 New - lifespan less than 12 months
 And find the total number of cusomers by each group */



 WITH customer_spending AS(
 SELECT
 c.customer_key,
 SUM(f.sales_amount) AS total_spending,
 MIN(order_date) AS first_order,
 MAX (order_date) AS last_order,
 DATEDIFF(month, MIN(order_date) ,MAX (order_date)) AS lifespan
 FROM gold.fact_sales f 
 LEFT JOIN gold.dim_customers c
 ON f.customer_key=c.customer_key
 GROUP BY c.customer_key)

 SELECT
 customer_segment,
 COUNT (customer_key) AS total_cutsomers
 FROM(
 SELECT 
 customer_key,
 CASE WHEN lifespan >= 12 AND total_spending> 5000 THEN 'VIP'
      WHEN lifespan >= 12 AND total_spending<= 5000 THEN 'Regular'
      ELSE 'New'
END customer_segment
FROM customer_spending) t
GROUP BY customer_segment
ORDER BY total_cutsomers DESC


