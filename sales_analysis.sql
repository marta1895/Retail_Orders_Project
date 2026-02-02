DROP TABLE df_orders;

CREATE TABLE df_orders (
	order_id int primary key, 
	order_date date, 
	ship_mode varchar (20), 
	segment varchar (20), 
	country varchar (20), 
	city varchar (20), 
	state varchar (20), 
	postal_code varchar (20), 
	region varchar (20), 
	category varchar (20), 
	sub_category varchar (20), 
	product_id varchar (50), 
	quantity int,
	discount decimal (7, 2), 
	sale_price decimal (7, 2), 
	profit decimal (7, 2)
);

SELECT * FROM df_orders;

---
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    COUNT(*) AS sold_products_count
FROM df_orders
WHERE order_date >= DATE '2022-01-01'
  AND order_date < DATE '2024-01-01'
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;


------
SELECT DISTINCT sub_category
from df_orders;
SELECT
    sub_category,
    SUM(sale_price) AS total_sales
FROM df_orders
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 3;




-- Calculate total revenue per product using SUM, and format as currency
SELECT
	sub_category,
    product_id,
    TO_CHAR(SUM(sale_price * quantity), '$999,999.0') AS total_revenue
FROM df_orders
GROUP BY sub_category, product_id
ORDER BY total_revenue DESC
LIMIT 10;




-- Use Common Table Expressions (CTEs) to improve query readability and structure
WITH quantity_by_product AS (
    SELECT
        region,
		category,
		sub_category,
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM df_orders
    GROUP BY region, product_id, category, sub_category
),
-- Rank products within each region using a window function
ranked_products AS (
    SELECT
        region,
		category,
		sub_category,
        product_id,
        total_quantity_sold,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_quantity_sold DESC
        ) AS rank_in_region
    FROM quantity_by_product
)
-- Select the top 5 highest-selling products per region
SELECT
    region,
    rank_in_region,
	category,
	sub_category,
    product_id,
    total_quantity_sold
FROM ranked_products
WHERE rank_in_region <=5
ORDER BY region, rank_in_region;


-- Use CTEs to calculate total sales per month and year
WITH sales_by_month_and_year AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        SUM(sale_price) AS total_sales  -- keep it numeric for futu
    FROM df_orders
    GROUP BY order_year, order_month
)
SELECT
    order_month,
    -- Pivot sales by year using CASE
    TO_CHAR(SUM(CASE WHEN order_year = 2022 THEN total_sales ELSE 0 END), '$999,999.0') AS sales_2022,
    TO_CHAR(SUM(CASE WHEN order_year = 2023 THEN total_sales ELSE 0 END), '$999,999.0') AS sales_2023
FROM sales_by_month_and_year
GROUP BY order_month
ORDER BY order_month;


-- Monthly year-over-year total sales comparison across all categories (2022 vs 2023)

WITH sales_by_month AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        SUM(sale_price) AS total_sales
    FROM df_orders
    GROUP BY order_year, order_month
)
SELECT
	-- Converting numeric month values (1–12) into readable month names (Jan, Feb, etc.)
    TO_CHAR(
        DATE '2000-01-01' + (order_month - 1) * INTERVAL '1 month',
        'Mon'
    ) AS month,
    SUM(CASE WHEN order_year = 2022 THEN total_sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN total_sales ELSE 0 END) AS sales_2023
FROM sales_by_month
GROUP BY order_month
ORDER BY order_month;

-- Find the month with the highest sales for each category

WITH sales_by_category AS (
    SELECT
        category,
        TO_CHAR(order_date, 'YYYY_Mon') AS order_year_month,
        SUM(sale_price) AS total_sales
    FROM df_orders
    GROUP BY
        category,
        TO_CHAR(order_date, 'YYYY_Mon')
)
SELECT
    category,
    order_year_month,
    total_sales
FROM (
    SELECT
        category,
        order_year_month,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM sales_by_category
) ranked
WHERE sales_rank = 1;


-- Find the sub-category with the highest sales growth in 2023 compared to 2022

WITH sales_by_year AS (
	SELECT 
		sub_category,
		EXTRACT(YEAR FROM order_date) AS order_year,
		SUM(sale_price) AS total_sales
	FROM df_orders
	GROUP BY 
		sub_category,
		EXTRACT(YEAR FROM order_date)
),
sales_sum_by_year AS (
	SELECT 
		sub_category,
		SUM(CASE WHEN order_year=2022 THEN total_sales ELSE 0 END) AS sales_2022,
		SUM(CASE WHEN order_year=2023 THEN total_sales ELSE 0 END) AS sales_2023
	FROM sales_by_year
	GROUP BY sub_category
)
SELECT 
	sub_category,
	sales_2022,
	sales_2023,
	-- NULLIF prevents division by zero when a sub-category has no sales in 2022
	ROUND((sales_2023 - sales_2022)*100/ NULLIF (sales_2022, 0), 2) AS growth_percentage
FROM sales_sum_by_year
ORDER BY growth_percentage DESC
LIMIT 1;