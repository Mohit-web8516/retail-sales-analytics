## SQL Analysis

Database: SQL Server (`RetailAnalytics`)
Schema: Normalized into `Customers`, `Products`, and `Orders` tables (loaded from a `Staging_Superstore` staging table)

Scripts:
- `/sql/schema.sql` — table creation
- `/sql/load_data.sql` — staging-to-normalized data load
- `/sql/queries.sql` — business analysis queries
- `/sql/verify.sql` — row count and data quality checks

### Key Findings

**1. Seasonal revenue pattern**
Revenue consistently peaks in November–December each year and drops sharply in January–February. November 2017 was the highest-revenue month in the dataset ($118,447), while January 2015 was among the lowest ($11,951). Revenue also grew year-over-year from 2014 to 2017.

**2. Discounting above 20% turns orders unprofitable**
Average profit per order declines as discount level increases:
| Discount Band | Orders | Avg Profit/Order |
|---|---|---|
| No Discount | 4,798 | +$66.90 |
| Low (0–20%) | 3,803 | +$26.50 |
| Medium (20–40%) | 460 | -$77.86 |
| High (40%+) | 933 | -$106.37 |

This is the single strongest insight in the dataset: discounts above 20% consistently lose money on average, and high discounts (40%+) are the worst-performing segment despite still generating meaningful sales volume.

**3. High sales ≠ high profit at the product level**
The Canon imageCLASS 2200 Advanced Copier is the top performer on both sales ($61,599) and profit ($25,199). However, the Cisco TelePresence System (3rd highest sales, $22,638) posts -$1,811 profit, and the GBC DocuBind P400 similarly sells well ($17,065) but loses -$1,878. High revenue products should not be assumed profitable without checking margin.

**4. Regional concentration risk**
The West region drives the large majority of the business ($2.1M sales, $270K profit, 4,576 orders). Central shows only 5 orders and a small loss, suggesting either genuinely minimal presence in that region or a data completeness gap worth flagging.

**5. Top customer is unprofitable**
Sean Miller is the single highest-revenue customer ($25,043) but generates -$1,980 in profit overall — the business's biggest customer relationship is currently a net loss, likely driven by high discounting on his orders.

### Business Recommendations
- Cap discounts at 20% as a default policy; require approval for anything higher, since orders above that threshold lose money on average
- Review pricing/cost structure for Cisco TelePresence and GBC DocuBind P400 — high sales volume is being undermined by poor margins
- Investigate Sean Miller's order-level discount history specifically — the business's largest customer relationship is currently unprofitable
- Investigate the Central region's low order volume — determine if this reflects genuinely low market presence or a data/reporting gap