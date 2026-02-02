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

--- Own findings -------------------------------------

-- Total Orders -------

WITH total_orders_year AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        COUNT(*) AS total_orders
    FROM df_orders
    GROUP BY EXTRACT(YEAR FROM order_date)
)
SELECT
    MAX(CASE WHEN year = 2022 THEN total_orders END) AS orders_2022,
    MAX(CASE WHEN year = 2023 THEN total_orders END) AS orders_2023
FROM total_orders_year;


--- Sales by states -------
SELECT
state,
SUM(sale_price * quantity) AS total_sales
FROM df_orders
GROUP BY state 
ORDER BY total_sales DESC;

--- Sales by sub-category with sales more then 800K -----
WITH sales_per_subcategory AS (
    SELECT
        sub_category,
        SUM(sale_price * quantity) AS total_sales
    FROM df_orders
    GROUP BY sub_category
),
grouped_subcategories AS (
    SELECT
        CASE 
            WHEN total_sales > 800000 THEN sub_category
            ELSE 'Other'
        END AS sub_category_group,
        SUM(total_sales) AS total_sales
    FROM sales_per_subcategory
    GROUP BY
        CASE 
            WHEN total_sales > 800000 THEN sub_category
            ELSE 'Other'
        END
)
SELECT
    sub_category_group AS sub_category,
    total_sales,
    SUM(total_sales) OVER () AS total_sales_overall,
    ROUND(
        total_sales / SUM(total_sales) OVER (),
        2
    ) AS pct_of_total
FROM grouped_subcategories
ORDER BY total_sales DESC;

	
-- Total Revenue--------
SELECT
    SUM(sale_price * quantity) AS combined_revenue_2022_2023
FROM df_orders
WHERE EXTRACT(YEAR FROM order_date) IN (2022, 2023);

--- Revenue Compared 2022 vs 2023 ---
WITH total_revenue_year AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(sale_price * quantity) AS revenue
    FROM df_orders
    GROUP BY EXTRACT(YEAR FROM order_date)
)
SELECT
    MAX(CASE WHEN year = 2022 THEN revenue END) AS revenue_2022,
    MAX(CASE WHEN year = 2023 THEN revenue END) AS revenue_2023
FROM total_revenue_year;


--- Profit Growth ----
WITH yearly_profit AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        SUM(profit) AS total_profit
    FROM df_orders
    WHERE EXTRACT(YEAR FROM order_date) IN (2022, 2023)
    GROUP BY order_year
)
SELECT
    ROUND(
        (MAX(CASE WHEN order_year = 2023 THEN total_profit END)
         - MAX(CASE WHEN order_year = 2022 THEN total_profit END))
        / NULLIF(MAX(CASE WHEN order_year = 2022 THEN total_profit END), 0)
        * 100, 2
    ) AS profit_growth_pct
FROM yearly_profit;


---Top 3 sub-categories------
SELECT
    sub_category,
    SUM(sale_price) AS total_sales
FROM df_orders
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 3;
-----------------------Business questions---------

---1.Find Top 10 Revenue-Generating Products ---

-- Calculate total revenue per product using SUM, and find the top 10 revenue-generating products
SELECT
    product_id,
    SUM(sale_price * quantity) AS total_revenue
FROM df_orders
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;



---2. –Top 3 Sub-Categories by Total Quantity Sold per Region ---

-- Use Common Table Expressions (CTEs) to improve query readability and structure
WITH sales_by_subcategory AS (
    SELECT
        region,
        sub_category,
        SUM(quantity) AS total_quantity_sold
    FROM df_orders
    GROUP BY region, sub_category
),
-- Rank sub-categories within each region using a window function
ranked_subcategories AS (
    SELECT
        region,
        sub_category,
        total_quantity_sold,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_quantity_sold DESC
        ) AS rank_in_region
    FROM sales_by_subcategory
)
-- Select the top 3 highest-selling sub-categories per region
SELECT
    region,
    rank_in_region,
    sub_category,
    total_quantity_sold
FROM ranked_subcategories
WHERE rank_in_region <= 3
ORDER BY region, rank_in_region;


---3. Monthly Sales Comparison (2022 vs 2023)  with Growth % ----

WITH sales_by_month AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        SUM(sale_price * quantity) AS total_revenue
    FROM df_orders
    GROUP BY order_year, order_month
),
months_sales AS (
    SELECT
        order_month,
		-- Converting numeric month values (1–12) into readable month names (Jan, Feb, etc.)
    	TO_CHAR(
            DATE '2000-01-01' + (order_month - 1) * INTERVAL '1 month',
            'Mon'
        ) AS month_name,
        SUM(CASE WHEN order_year = 2022 THEN total_revenue END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN total_revenue END) AS sales_2023
    FROM sales_by_month
    GROUP BY order_month
)
SELECT
    order_month,
    month_name,
    sales_2022,
    sales_2023,
    ROUND(
        (sales_2023 - sales_2022) / NULLIF(sales_2022, 0) * 100,
        1
    ) AS growth_pct
FROM months_sales
ORDER BY order_month;


---4.Find the month with the highest sales for each category ----

--Use CTEs to calculate total sales per category per year-month
WITH sales_by_category AS (
    SELECT
        category,
        DATE_TRUNC('month', order_date) AS order_month,
        SUM(sale_price * quantity) AS total_sales
    FROM df_orders
    GROUP BY category, order_month
),
ranked_months AS (
    SELECT
        category,
        order_month,
        total_sales,
		-- Rank months within each category by total sales using a window function
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM sales_by_category
)
SELECT
    category,
    TO_CHAR(order_month, 'YYYY-Mon') AS order_year_month,
    total_sales
FROM ranked_months
WHERE sales_rank = 1;


---5. Find the sub-category with the highest sales growth in 2023 compared to 2022 ----

WITH sales_by_year AS (
	SELECT 
		sub_category,
		EXTRACT(YEAR FROM order_date) AS order_year,
		SUM(sale_price * quantity) AS total_sales
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
WHERE sales_2022 > 0 -- Excludes sub-categories with zero sales in 2022 to avoid division by zero
ORDER BY growth_percentage DESC
LIMIT 1;