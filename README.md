# Retail Sales & Customer Analytics — SQL, Python & Power BI

An end-to-end data analytics project analyzing retail sales, discounting 
behavior, and product/category profitability using the classic Superstore 
dataset, built as a complete SQL → Python → Power BI pipeline.

## Problem Statement

A retail business wants to understand what's actually driving profit — not 
just revenue — across products, categories, regions, and discount policies. 
This project analyzes ~10,000 transactions to answer:

1. Is revenue seasonal, and is the business growing year over year?
2. Does discounting help or hurt profitability?
3. Which products, categories, and regions are genuinely profitable — not 
   just high-selling?

## Tools Used

- **SQL Server** — data cleaning, normalization, and business analysis queries
- **Python (Pandas, NumPy, Matplotlib, Seaborn)** — validation, feature 
  engineering, and visualization
- **Power BI** — interactive single-page dashboard with DAX measures
- **Git/GitHub** — version control

## Project Structure

```
retail-sales-analytics/
├── Data/              # Raw CSV and cleaned dataset
├── SQL/               # Schema, data load, verification, and analysis queries
├── notebooks/          # Python EDA and visualization notebooks
├── Dashboard/          # Power BI file and exported chart images
└── README.md
```

## Dataset

The classic "Sample Superstore" dataset — ~10,000 US retail transactions, 
including order details, customer info, product/category info, sales, 
discount, and profit.

## Data Cleaning & Data Quality Issues Found

- **One row with a NULL profit value** (Order ID CA-2017-168389, customer 
  Darrin Van Huff) — since this affected only 1 of 9,994 rows, it was 
  documented and excluded rather than imputed, to avoid fabricating a 
  financial figure.
- **Duplicate customer records with conflicting values** — some CustomerIDs 
  appeared multiple times with different City/State combinations across 
  orders, which initially violated the intended PRIMARY KEY constraint on 
  the normalized Customers table. Resolved using `GROUP BY` with `MAX()` as 
  a tie-breaker instead of a plain `DISTINCT`.
- **Column type misdetection on import** — SQL Server's import wizard 
  initially set `Profit` as NOT NULL, causing an insert failure; corrected 
  by explicitly allowing NULLs on that column before re-importing.

## SQL Analysis — Key Findings

**1. Revenue is seasonal and grows year over year.**
Revenue consistently peaks in November–December each year and drops sharply 
in January–February. November 2017 was the single highest-revenue month in 
the dataset. Overall revenue grew year over year from 2014 to 2017.

**2. Discounting above 20% turns orders unprofitable.**
Average profit per order declines steadily as discount level increases:

| Discount Band | Orders | Avg Profit/Order |
|---|---|---|
| No Discount | 4,798 | +$66.90 |
| Low (0–20%) | 3,803 | +$26.50 |
| Medium (20–40%) | 460 | -$77.86 |
| High (40%+) | 933 | -$106.37 |

This is the strongest insight in the dataset: discounts above 20% 
consistently lose money on average.

**3. High sales don't guarantee high profit at the product level.**
The Canon imageCLASS 2200 Advanced Copier is the top performer on both 
sales ($61,599) and profit ($25,199). However, the Cisco TelePresence System 
(3rd highest by sales) posts a $1,811 loss, and the GBC DocuBind P400 
similarly sells well but loses money — proving revenue alone is a poor 
indicator of profitability.

**4. Furniture has a margin problem, not a sales problem.**
Furniture generates the 2nd-highest total sales ($741,278) but converts only 
3.9% of that into profit ($18,871) — far below Technology (15.6% margin) 
and Office Supplies (13.8% margin). Total profit figures alone mask this — 
Furniture looks "fine" in aggregate but is structurally the weakest category 
on a per-dollar basis.

**5. Sales are heavily concentrated in the West region.**
The West region accounts for the large majority of total sales ($2.1M), 
dwarfing South, East, and Central — a concentration risk worth flagging for 
regional diversification.

## Business Recommendations

- Cap discounts at 20% as a default policy; require approval for anything 
  higher, since orders above that threshold lose money on average
- Review pricing/cost structure for Furniture and specific underperforming 
  products (Cisco TelePresence, GBC DocuBind P400) — high sales volume is 
  being undermined by poor margins
- Investigate regional concentration risk in the West and evaluate growth 
  opportunities in underrepresented regions

## Python Analysis

The Python notebooks (`/notebooks`) connect directly to the SQL Server 
database, cross-validate every SQL finding above, and add two additional 
insights:

- **Shipping delay has minimal impact on profitability** — average profit 
  margin stays consistently between 10–15% regardless of delivery time 
  (0–7 days)
- **Furniture's margin problem is confirmed at the order level** — the 
  distribution of order-level profit margins shows a distinct left tail of 
  loss-making orders, disproportionately pulling down the overall average 
  margin (12%) relative to the median (27%)

## Power BI Dashboard

An interactive single-page dashboard connected live to the SQL Server 
database, including:
- 5 KPI cards (Total Sales, Total Profit, Total Orders, Average Discount, 
  Profit Margin %)
- Region and Category slicers
- Monthly revenue trend by year
- Category-level sales vs. profit comparison
- Regional sales distribution
- Discount band vs. profit chart
- Top 10 products by sales

## How to Reproduce

1. Import the raw CSV in `/data` into SQL Server as a staging table
2. Run `/sql/schema.sql` and `/sql/load_data.sql` to build and populate the 
   normalized Customers, Products, and Orders tables
3. Run `/sql/verify.sql` to confirm row counts and check data quality
4. Run `/sql/queries.sql` for the core business analysis
5. Open `/notebooks/01_eda_and_cleaning.ipynb` to reproduce the Python 
   cleaning and validation
6. Open `/notebooks/02_data_visualization.ipynb` (or your visualization 
   notebook) to reproduce the charts
7. Open the Power BI file in `/dashboard` to explore the interactive dashboard