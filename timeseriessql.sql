
select * from timeseries;
##what is running total in timeseries##
select order_date,sales,sum(sales) over (order by order_date rows unbounded preceding) as running_total from timeseries order by order_date;
##Compare sales with previous days##
select order_date,sales,lag(sales) over(order by order_date) as prev_day_sales ,sales-lag(sales) over(order by order_date) as difference from timeseries order by order_date;
##how do we find moving average##
##the manager wants a three day moving average to understand smooth trend##
select order_date,sales,avg(sales) over(order by order_date rows between 2 preceding and current row)  as Moving_average_3_day from timeseries order by order_date desc;
##Calculate month over month growth##
SELECT order_date,sales,LAG(sales) OVER (ORDER BY order_date) AS prev_month_sales,ROUND((sales - LAG(sales) OVER (ORDER BY order_date))
        * 100.0
        / LAG(sales) OVER (ORDER BY order_date),
        2) AS mom_growth_pct          
FROM timeseries ORDER BY order_date;
##Year_over_year growth
select t1.year,t1.month,t1.sales,round((t1.sales-t2.sales)*100/t2.sales,2) as YOY_growth_pct from timeseries t1 join timeseries t2 on t1.month=t2.month and t1.year=t2.year+1 order by t1.year,t1.month;
##how do we find a paeak sales day
select order_date,sales from timeseries order by sales desc limit 1;
#How do we find moving 7days average
select order_date,sales,avg(sales) over(order by order_date rows between 6 preceding and current row) as moving_avg_7_day from timeseries order by order_date;



 