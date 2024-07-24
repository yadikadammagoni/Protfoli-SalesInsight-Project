# All Coustomers Records
select * from customers; 

# All Markets Regions
select * from markets; # we have paris and Newyork so we need to remove it

# All Products 
select * from products;

# All Transactions 
select * from transactions; # We can see sale amount in negative

# All Date 
select * from date;

# Total number of Customers
select count(*) from customers;

# Total Sales Transactions
select count(*) from transactions;

# Currency duplicate
select distinct(currency) from transactions; # We have INR and USD are duplicated

select count(*) from transactions where currency = 'INR'; # we have 279 recodrs with INR
select count(*) from transactions where currency = 'INR\r'; # we have 15000 records with INR\r

select count(*) from transactions where currency = 'USD'; # we have 2 records with USD
select count(*) from transactions where currency  = 'USD\r'; # we have 2 records with USD\r

# Lets See the transaction for Chennai Market(Markets_code = Mark001)
select count(*) from transactions where market_code = 'Mark001'; # total transaction related is 1035

# Distinict Products sold in chennai
select distinct product_code from transactions where market_code = 'Mark001';
select count(distinct(product_code)) from transactions where market_code = 'Mark001'; # 77 distinct product out of total product

# Type of currency used in chennai
select distinct currency from transactions where market_code = 'Mark001'; # all transaction were in Indian Currency

# Total sales according to years
select sum(ts.sales_amount) as total_amount, dt.year
from transactions as ts
inner join date as dt on dt.date = ts.order_date
group by dt.year;

# Total sales in 2020
select sum(sales_amount)
from transactions
inner join date on date.date = transactions.order_date
where date.year='2020';

# Total Sales according to the Market or Regions
select sum(ts.sales_amount) as total_sales, dt.year, mkt.markets_name
from transactions as ts
join date as dt on dt.date = ts.order_date
join markets as mkt on mkt.markets_code = ts.market_code
where dt.year='2020'
group by mkt.markets_name
order by total_sales desc; # the highest sales in Delhi in 2020

# Which product is sold highest in Delhi NCR in 2020
select pdt.product_code, sum(ts.sales_amount)as total_sales, mrk.markets_name
from transactions as ts
join products as pdt on pdt.product_code = ts.product_code
join date as dt on dt.date = ts.order_date
join markets as mrk on mrk.markets_code = ts.market_code
where dt.year = '2020' and mrk.markets_name = 'Delhi NCR'
group by pdt.product_code
order by total_sales desc; # in delhi the highest sold product_code is Prod071

# Which Product sales is high in 2020
select pdt.product_code, sum(ts.sales_amount)as total_sales
from transactions as ts
join products as pdt on pdt.product_code = ts.product_code
join date as dt on dt.date = ts.order_date
where dt.year = '2020'
group by pdt.product_code
order by total_sales desc; # in 2020 the Prod047 is sold highest

# Revenue according to the month in 2020
select sum(ts.sales_amount) as total_Sales, dt.month_name, dt.year
from transactions as ts
join date as dt on dt.date = ts.order_date
where dt.year = '2020'
group by dt.month_name
order by total_Sales desc;

# we have currency in USD and USD\r but this data is about 
#Indian Market so Lets convert the currency and negative values including zero
select *,
	if(sales_amount <='0',
		(select avg(sales_amount) from transactions),
        if (currency='USD' or currency = 'USD\r',
			sales_amount*65,
            sales_amount
            )
	) as adjusted_amount
from transactions;

 /* Method2 */

select *,
	case
		when sales_amount<=0 then (select avg(sales_amount) from transactions)
        when currency = 'USD' or currency ='USD\r' 
        then sales_amount * 65
        else sales_amount
	end
from transactions
where sales_amount > 0;
