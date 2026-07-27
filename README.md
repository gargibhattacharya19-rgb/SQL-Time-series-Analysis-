# 📈 Time Series SQL Analysis

A collection of SQL queries demonstrating common **Time Series Analysis** techniques using SQL Window Functions. This project uses a sales dataset to perform trend analysis, running totals, moving averages, and growth calculations.

---

## 📂 Project Files

```
├── TIMESERIES.xlsx       # Sample sales dataset
├── timeseriessql.sql     # SQL queries
└── README.md
```

---

## Dataset

**Table Name:** `timeseries`

| Column | Data Type | Description |
|---------|-----------|-------------|
| order_date | DATE | Date of the sale |
| year | INT | Year of the sale |
| month | VARCHAR | Month name |
| sales | NUMERIC | Sales amount |

### Sample Data

| order_date | year | month | sales |
|------------|------|-------|------:|
| 2023-01-01 | 2023 | Jan | 1200 |
| 2023-02-01 | 2023 | Feb | 1350 |
| 2023-03-01 | 2023 | Mar | 1280 |
| 2023-04-01 | 2023 | Apr | 1450 |

---

# SQL Concepts Covered

- Window Functions
- Running Total
- LAG()
- Moving Average
- Month-over-Month (MoM) Growth
- Year-over-Year (YoY) Growth
- Peak Sales Analysis
- Rolling 7-Day Average

---

# SQL Queries

## 1. View the Dataset

```sql
SELECT *
FROM timeseries;
```

**Purpose**

Displays all records from the dataset.

---

## 2. Running Total

```sql
SELECT
    order_date,
    sales,
    SUM(sales) OVER (
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS running_total
FROM timeseries
ORDER BY order_date;
```

**Explanation**

Calculates the cumulative sales from the first record up to the current date.

---

## 3. Compare Sales with Previous Day

```sql
SELECT
    order_date,
    sales,
    LAG(sales) OVER (ORDER BY order_date) AS prev_day_sales,
    sales -
    LAG(sales) OVER (ORDER BY order_date) AS difference
FROM timeseries
ORDER BY order_date;
```

**Explanation**

Compares today's sales with the previous day's sales using the `LAG()` window function.

---

## 4. Three-Day Moving Average

```sql
SELECT
    order_date,
    sales,
    AVG(sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average_3_day
FROM timeseries
ORDER BY order_date DESC;
```

**Explanation**

Calculates the average sales over the current day and the previous two days to smooth short-term fluctuations.

---

## 5. Month-over-Month (MoM) Growth

```sql
SELECT
    order_date,
    sales,
    LAG(sales) OVER (ORDER BY order_date) AS prev_month_sales,
    ROUND(
        (sales - LAG(sales) OVER (ORDER BY order_date))
        * 100.0 /
        LAG(sales) OVER (ORDER BY order_date),
        2
    ) AS mom_growth_pct
FROM timeseries
ORDER BY order_date;
```

**Explanation**

Calculates the percentage increase or decrease in sales compared with the previous month.

---

## 6. Year-over-Year (YoY) Growth

```sql
SELECT
    t1.year,
    t1.month,
    t1.sales,
    ROUND(
        (t1.sales - t2.sales) * 100.0 / t2.sales,
        2
    ) AS yoy_growth_pct
FROM timeseries t1
JOIN timeseries t2
ON t1.month = t2.month
AND t1.year = t2.year + 1
ORDER BY t1.year, t1.month;
```

**Explanation**

Compares sales for the same month across different years to calculate yearly growth.

---

## 7. Peak Sales Day

```sql
SELECT
    order_date,
    sales
FROM timeseries
ORDER BY sales DESC
LIMIT 1;
```

**Explanation**

Finds the date with the highest sales value.

---

## 8. Seven-Day Moving Average

```sql
SELECT
    order_date,
    sales,
    AVG(sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_day
FROM timeseries
ORDER BY order_date;
```

**Explanation**

Calculates a rolling seven-day average to identify long-term sales trends.

---

# SQL Functions Used

- `SUM()`
- `AVG()`
- `LAG()`
- `ROUND()`
- `ORDER BY`
- `JOIN`
- Window Functions (`OVER()`)

---

# Key Learning Outcomes

- Analyze trends in time-series data.
- Compute cumulative totals using window functions.
- Compare current values with previous periods.
- Smooth fluctuations using moving averages.
- Measure Month-over-Month and Year-over-Year growth.
- Identify peak sales periods.

---

# Requirements

- MySQL 8.0+ (Window Functions supported)
- PostgreSQL
- SQL Server
- Oracle Database

---

# Author

**Your Name**

---

## Future Improvements

- Rolling 30-day average
- Cumulative monthly sales
- Quarterly sales trends
- Year-to-date (YTD) sales
- Ranking top-performing months
- Forecasting with SQL and Python
- Interactive dashboards using Power BI or Tableau
