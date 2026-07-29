##how do we find a paeak sales day
select order_date,sales from timeseries order by sales desc limit 1;
#How do we find moving 7days average
select order_date,sales,avg(sales) over(order by order_date rows between 6 preceding and current row) as moving_avg_7_day from timeseries order by order_date;
##Cumulative sum of sales for each day for each product
select order_date,product,sales,sum(sales) over (partition by product order by order_date rows unbounded preceding) as cumulative_sales from daily_sales order by product,order_date;
##First sale date for each customer
select customer_id, min(order_date) as First_sales_date from daily_sales group by customer_id;
##Find the  number of active customers in a 30 day rolling window 
SELECT
    o1.order_date,
    COUNT(DISTINCT o2.customer_id) AS active_customers_30_day
FROM daily_sales o1
JOIN daily_sales o2
ON o2.order_date BETWEEN
   DATE_SUB(o1.order_date, INTERVAL 30 DAY)
   AND o1.order_date
GROUP BY o1.order_date
ORDER BY o1.order_date;
##Find week over week growth in sales
select order_date,sales,lag(sales) over (order by order_date) as prev_weekly_sales ,round(sales-lag(sales) over(order by week_start)/lag(sales) over (order by week_start)*100,2) as wow_growthpct
 from daily_sales order by week_start;
SELECT *
FROM daily_sales;