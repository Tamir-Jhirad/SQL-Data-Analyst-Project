# 📊 SQL Data Analytics Project

This project demonstrates how to load, structure, and query data in a SQL Server environment using datasets in CSV format.

## 📁 Project Structure

---

## ⚙️ Step 1: Load the Database

Run the script `LoadDataBase.sql` to initialize the database.

This script will:

- Truncate existing data from the tables:
  - `gold.dim_customers`
  - `gold.dim_products`
  - `gold.fact_sales`
- Load fresh data from the corresponding `.csv` files using `BULK INSERT`.

### 📌 Note:
Make sure the file paths in the script match the actual location of your CSV files.

For example:
```sql
FROM 'D:\Program Files (x86)\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'


> 💡 Tip: You can run queries directly in SQL Server Management Studio (SSMS), Azure Data Studio, or any SQL client of your choice.

---
## 📊 Step 2: Run the Analysis Queries

After successfully loading the data into the database, it's time to run the analytical queries and explore insights!

Open the `analysis-queries.sql` file (or your own custom SQL script), and execute the queries to:

- Segment customers based on lifespan and total spending (e.g., **VIP**, **Regular**, **New**)
- Analyze sales trends and product performance
- Generate reports or visualizations as needed
