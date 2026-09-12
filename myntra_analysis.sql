-- ============================================================
-- MYNTRA PRODUCT ANALYSIS
-- Business questions answered with SQL: filtering, aggregates,
-- GROUP BY, subqueries, and ranking on Myntra product listings.
-- ============================================================

USE MYNTRA;

SELECT * FROM PRODUCTS;

-- ============================================================
-- 1. DATA EXPLORATION & FILTERING
-- ============================================================

-- Unique brands in the dataset
SELECT DISTINCT BRAND_NAME FROM PRODUCTS;

-- Unique product categories served by Adidas
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG FROM PRODUCTS
WHERE BRAND_TAG = 'ADIDAS';

-- Adidas categories where discounted price > 5000
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE FROM PRODUCTS
WHERE BRAND_TAG = 'ADIDAS' AND DISCOUNTED_PRICE > 5000;

-- Adidas categories where discounted price > 5000 AND marked price > 8000
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE, MARKED_PRICE FROM PRODUCTS
WHERE BRAND_TAG = 'ADIDAS' AND DISCOUNTED_PRICE > 5000 AND MARKED_PRICE > 8000;

-- Roadster categories priced between 3000 and 5000
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE FROM PRODUCTS
WHERE BRAND_TAG = 'ROADSTER' AND DISCOUNTED_PRICE BETWEEN 3000 AND 5000;

-- Adidas or Puma categories priced between 3000 and 8000 (two equivalent styles)
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE FROM PRODUCTS
WHERE (BRAND_TAG = 'ADIDAS' OR BRAND_TAG = 'PUMA') AND (DISCOUNTED_PRICE BETWEEN 3000 AND 8000);

SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE FROM PRODUCTS
WHERE BRAND_TAG IN ('ADIDAS', 'PUMA') AND DISCOUNTED_PRICE BETWEEN 3000 AND 8000;

-- Categories NOT from H&M or Biba, priced between 2000 and 4000
SELECT DISTINCT PRODUCT_TAG, BRAND_TAG, DISCOUNTED_PRICE FROM PRODUCTS
WHERE BRAND_TAG NOT IN ('H&M', 'BIBA') AND DISCOUNTED_PRICE BETWEEN 2000 AND 4000;

-- Brands where rating count > 3000, limited to Tshirts and Flip-Flops
SELECT PRODUCT_TAG, BRAND_NAME, RATING_COUNT FROM PRODUCTS
WHERE PRODUCT_TAG IN ('TSHIRTS', 'FLIP-FLOPS') AND RATING_COUNT > 3000;

-- Computed column: discount amount and discount %
SELECT PRODUCT_NAME, BRAND_NAME, MARKED_PRICE, DISCOUNTED_PRICE,
       MARKED_PRICE - DISCOUNTED_PRICE AS 'DISCOUNT_AMOUNT',
       ROUND(((MARKED_PRICE - DISCOUNTED_PRICE) / MARKED_PRICE) * 100, 2) AS 'DISCOUNT_%'
FROM PRODUCTS;

-- ============================================================
-- 2. AGGREGATE FUNCTIONS
-- ============================================================

-- Highest / lowest marked price
SELECT MAX(MARKED_PRICE), MIN(MARKED_PRICE) FROM PRODUCTS;
SELECT * FROM PRODUCTS WHERE MARKED_PRICE IN (113999, 50);

-- Highest / lowest discounted price
SELECT MAX(DISCOUNTED_PRICE), MIN(DISCOUNTED_PRICE) FROM PRODUCTS;
SELECT * FROM PRODUCTS WHERE DISCOUNTED_PRICE IN (45900, 49);

-- Average marked and discounted price
SELECT AVG(MARKED_PRICE), AVG(DISCOUNTED_PRICE) FROM PRODUCTS;

-- Total products listed
SELECT COUNT(*) FROM PRODUCTS;

-- NOTE: this does NOT work as intended — BRAND_NAME repeats per row while
-- MAX(MARKED_PRICE) collapses to a single overall value, so SQL can't map
-- one brand to one max price without a GROUP BY. Left here intentionally
-- as an example of the "single value vs grouped value" mapping problem.
SELECT BRAND_NAME, MAX(MARKED_PRICE) FROM PRODUCTS;

-- Adidas: min, max, and average marked price
SELECT DISTINCT MIN(MARKED_PRICE), MAX(MARKED_PRICE), AVG(MARKED_PRICE) FROM PRODUCTS
WHERE BRAND_NAME = 'ADIDAS';

-- Total revenue generated across all products (discounted_price * rating_count as a proxy for units sold)
SELECT SUM(DISCOUNTED_PRICE * RATING_COUNT) AS 'TOTAL_REVENUE' FROM PRODUCTS;

-- Total revenue generated from Tshirts specifically
SELECT SUM(DISCOUNTED_PRICE * RATING_COUNT) AS 'TSHIRT_REVENUE' FROM PRODUCTS
WHERE PRODUCT_TAG = 'TSHIRTS';

-- Number of distinct categories Nike serves
SELECT COUNT(DISTINCT PRODUCT_TAG) FROM PRODUCTS
WHERE BRAND_NAME = 'NIKE';

-- ============================================================
-- 3. GROUP BY — BRAND-LEVEL ANALYSIS
-- ============================================================

-- Total revenue by brand
SELECT BRAND_NAME, SUM(DISCOUNTED_PRICE) FROM PRODUCTS
GROUP BY BRAND_NAME;

-- Number of products listed per brand
SELECT BRAND_NAME, COUNT(PRODUCT_TAG) FROM PRODUCTS
GROUP BY BRAND_NAME;

-- Most expensive brand on average (by discounted price)
SELECT BRAND_NAME, AVG(DISCOUNTED_PRICE) AS PRICE FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY PRICE DESC LIMIT 1;

-- Top 5 brands by revenue
SELECT BRAND_NAME, SUM(RATING_COUNT * DISCOUNTED_PRICE) AS REVENUE FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY REVENUE DESC LIMIT 5;

-- Top 5 brands by units sold (rating_count as a proxy for units)
SELECT BRAND_NAME, SUM(RATING_COUNT) AS UNITS_SOLD FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY UNITS_SOLD DESC LIMIT 5;

-- Top 5 brands by product variety (distinct product names in their inventory)
SELECT BRAND_NAME, COUNT(DISTINCT PRODUCT_NAME) AS VARIETY FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY VARIETY DESC LIMIT 5;

-- Top 5 most expensive brands on average
SELECT BRAND_NAME, AVG(DISCOUNTED_PRICE) FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY AVG(DISCOUNTED_PRICE) DESC LIMIT 5;

-- Top 5 least expensive brands on average
SELECT BRAND_NAME, AVG(DISCOUNTED_PRICE) FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY AVG(DISCOUNTED_PRICE) ASC LIMIT 5;

-- Top 10 brands offering the biggest average discount
SELECT BRAND_NAME, AVG(MARKED_PRICE - DISCOUNTED_PRICE) AS AVG_DISCOUNT FROM PRODUCTS
GROUP BY BRAND_NAME ORDER BY AVG_DISCOUNT DESC LIMIT 10;

-- Which category of Dyson sells the most (by units)
SELECT PRODUCT_TAG, BRAND_NAME, SUM(RATING_COUNT) FROM PRODUCTS
WHERE BRAND_NAME = 'DYSON'
GROUP BY PRODUCT_TAG ORDER BY SUM(RATING_COUNT) DESC LIMIT 1;

-- Best-selling (category, brand) combination overall
SELECT PRODUCT_TAG, BRAND_NAME, SUM(RATING_COUNT) FROM PRODUCTS
GROUP BY PRODUCT_TAG, BRAND_NAME ORDER BY SUM(RATING_COUNT) DESC LIMIT 1;

-- Revenue by (category, brand), top 10
SELECT PRODUCT_TAG, BRAND_TAG, SUM(RATING_COUNT) FROM PRODUCTS
GROUP BY PRODUCT_TAG, BRAND_TAG ORDER BY SUM(RATING_COUNT) DESC LIMIT 10;

-- Top 5 brands by units sold within the Dresses category
SELECT BRAND_TAG, SUM(RATING_COUNT), PRODUCT_TAG FROM PRODUCTS
WHERE PRODUCT_TAG = 'DRESSES'
GROUP BY BRAND_TAG ORDER BY SUM(RATING_COUNT) DESC LIMIT 5;

-- Average discounted price by (category, brand) combination
SELECT AVG(DISCOUNTED_PRICE), PRODUCT_TAG, BRAND_TAG FROM PRODUCTS
GROUP BY PRODUCT_TAG, BRAND_TAG ORDER BY AVG(DISCOUNTED_PRICE) DESC;

-- ============================================================
-- 4. GROUP BY — CATEGORY-LEVEL ANALYSIS
-- ============================================================

-- Number of products per category
SELECT PRODUCT_TAG, COUNT(*) FROM PRODUCTS
GROUP BY PRODUCT_TAG;

-- Top 5 categories by revenue
SELECT DISTINCT PRODUCT_TAG, SUM(RATING_COUNT), SUM(RATING_COUNT * DISCOUNTED_PRICE) AS REVENUE FROM PRODUCTS
GROUP BY PRODUCT_TAG ORDER BY REVENUE DESC LIMIT 5;

-- Top 10 best-selling categories (by units)
SELECT PRODUCT_TAG, SUM(RATING_COUNT) FROM PRODUCTS
GROUP BY PRODUCT_TAG ORDER BY SUM(RATING_COUNT) DESC LIMIT 10;

-- Top 5 most expensive categories on average
SELECT PRODUCT_TAG, AVG(DISCOUNTED_PRICE) FROM PRODUCTS
GROUP BY PRODUCT_TAG ORDER BY AVG(DISCOUNTED_PRICE) DESC LIMIT 5;

-- Top category, by product name specifically, overall
SELECT PRODUCT_NAME, MAX(RATING_COUNT) FROM PRODUCTS
GROUP BY PRODUCT_NAME ORDER BY MAX(RATING_COUNT) DESC LIMIT 1;

-- Tshirts: units sold, broken down by rating value
SELECT SUM(RATING_COUNT), RATING FROM PRODUCTS
WHERE PRODUCT_TAG = 'TSHIRTS'
GROUP BY RATING ORDER BY SUM(RATING_COUNT);

-- Tshirts: average discounted price, broken down by rating value
SELECT AVG(DISCOUNTED_PRICE), RATING FROM PRODUCTS
WHERE PRODUCT_TAG = 'TSHIRTS'
GROUP BY RATING ORDER BY AVG(DISCOUNTED_PRICE);

-- ============================================================
-- 5. SUBQUERIES
-- ============================================================

-- Find the cheapest product's full details in one step, using a subquery
-- (instead of first finding MIN(price), then re-querying for it separately)
SELECT * FROM PRODUCTS
WHERE DISCOUNTED_PRICE = (SELECT MIN(DISCOUNTED_PRICE) FROM PRODUCTS);

-- ============================================================
-- 6. SORTING & RANKING (ORDER BY / LIMIT / OFFSET)
-- ============================================================

-- Top 5 products by rating count
SELECT * FROM PRODUCTS ORDER BY RATING_COUNT DESC LIMIT 5;

-- Top 5 products by a combined "popularity" score (rating * rating_count)
SELECT *, (RATING_COUNT * RATING) AS 'CUM_RATING' FROM PRODUCTS
ORDER BY CUM_RATING DESC LIMIT 5;

-- Second most expensive product (LIMIT with OFFSET)
SELECT * FROM PRODUCTS
ORDER BY DISCOUNTED_PRICE DESC LIMIT 1, 1;

-- 10th lowest-rated product
SELECT * FROM PRODUCTS
ORDER BY RATING ASC LIMIT 9, 1;

-- Worst-rated Nike product, excluding unrated (rating = 0) products
SELECT * FROM PRODUCTS
WHERE BRAND_NAME = 'NIKE' AND RATING != 0
ORDER BY RATING ASC;

-- Top 10 best-rated Tshirts from Nike or Adidas
SELECT * FROM PRODUCTS
WHERE BRAND_NAME IN ('ADIDAS', 'NIKE') AND PRODUCT_TAG = 'TSHIRTS'
ORDER BY RATING * RATING_COUNT DESC LIMIT 10;

-- Worst-rated 10 products among those with at least 100 ratings
SELECT PRODUCT_TAG, RATING_COUNT, RATING FROM PRODUCTS
WHERE RATING_COUNT >= 100
ORDER BY RATING_COUNT ASC LIMIT 10;

-- Last 10 products alphabetically by name
SELECT * FROM PRODUCTS
ORDER BY PRODUCT_NAME DESC LIMIT 10;

-- NOTE: known issue — `PRODUCT_TAG ('TSHIRTS')` is invalid syntax
-- (should be `PRODUCT_TAG = 'TSHIRTS'` or `PRODUCT_TAG IN ('TSHIRTS')`).
-- Left as originally written; will throw a syntax error if run as-is.
SELECT PRODUCT_TAG, BRAND_NAME, DISCOUNTED_PRICE FROM PRODUCTS
WHERE BRAND_NAME IN ('ADIDAS', 'NIKE') AND PRODUCT_TAG ('TSHIRTS') AND DISCOUNTED_PRICE BETWEEN 1000 AND 2000
ORDER BY BRAND_NAME ASC, DISCOUNTED_PRICE ASC;
