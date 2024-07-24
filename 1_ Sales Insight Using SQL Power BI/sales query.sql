SELECT * FROM sales.customers;
-- Show total number of customers
SELECT count(*) FROM sales.customers;

SELECT * FROM sales.products;
SELECT * FROM sales.markets;
SELECT * FROM sales.transactions;
-- Show total number of transactions
SELECT count(*) FROM sales.transactions;

-- Show transactions for Chennai market (market code for chennai is Mark001)
SELECT * FROM sales.transactions
WHERE market_code= 'Mark001'
LIMIT 5;

SELECT * FROM sales.date;
SELECT sales.transactions.*,sales.date.* 
FROM sales.transactions
INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date;
-- 
SELECT SUM(sales.transactions.sales_amount)
FROM sales.transactions
INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year=2020;
-- 
SELECT SUM(sales.transactions.sales_amount)
FROM sales.transactions
INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year=2020 AND sales.transactions.market_code='Mark001';

-- Show distrinct product codes that were sold in chennai
SELECT DISTINCT product_code FROM sales.transactions WHERE market_code='Mark001';

-- Show transactions where currency is US dollars
SELECT * from transactions where currency="USD";
SELECT * from transactions;










