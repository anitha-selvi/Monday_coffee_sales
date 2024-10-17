use coffee_db;

-- Q1) Find total sales made by each customer
SELECT cu.customer_name, SUM(s.total) AS total_sales
FROM sales s
JOIN customers cu
ON s.customer_id = cu.customer_id
GROUP BY cu.customer_name;

-- Q2) Retrieve cities where average sales rating is above 4
SELECT c.city_name, AVG(s.rating) AS avg_rating
FROM sales s
JOIN customers cu
ON s.customer_id = cu.customer_id
JOIN city c
ON cu.city_id = c.city_id
GROUP BY city_name
HAVING AVG(s.rating) > 4;


-- Q3) Get the total number of sales made per product
SELECT product_name, COUNT(sale_id) AS sales_count
FROM sales
JOIN products ON sales.product_id = products.product_id
GROUP BY product_name;

-- Q4) List all sales made in the current year
SELECT * 
FROM sales
WHERE YEAR(sale_date) = YEAR(CURDATE());

-- Q5) Find the top 3 cities based on customer count

SELECT c.city_name, COUNT(cu.customer_id) AS customer_count
FROM customers cu
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY customer_count DESC
LIMIT 3;

-- Q6) Recommend the top 3 cities for new coffee shop locations based on sales volume and market potential

SELECT c.city_name, SUM(s.total) AS total_sales, COUNT(s.sale_id) AS sales_volume, AVG(c.population) AS avg_population
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY total_sales DESC, sales_volume DESC
LIMIT 3;


-- Q7) Rank cities based on their total sales

SELECT c.city_name, SUM(s.total) AS total_sales,
       RANK() OVER (ORDER BY SUM(s.total) DESC) AS sales_rank
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name;

-- Q8) Find cities with the most product sales (by product count)

SELECT c.city_name, COUNT(s.product_id) AS product_sales_count
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY product_sales_count DESC
LIMIT 3;

-- Q9) Find the city with the highest average customer rating

SELECT city_name, avg_rating
FROM (
    SELECT c.city_name, AVG(s.rating) AS avg_rating
    FROM sales s
    JOIN customers cu ON s.customer_id = cu.customer_id
    JOIN city c ON cu.city_id = c.city_id
    GROUP BY c.city_name
) AS city_ratings
ORDER BY avg_rating DESC
LIMIT 1;

-- Q10) Find the running total of sales for each city (cumulative sales)

SELECT c.city_name, s.sale_date, s.total,
       SUM(s.total) OVER (PARTITION BY c.city_name ORDER BY s.sale_date) AS cumulative_sales
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
ORDER BY c.city_name, s.sale_date;
