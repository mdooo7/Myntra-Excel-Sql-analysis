Myntra Product Analysis — Excel + SQL
A two-part analysis of a Myntra product listings dataset: cleaning and pivot-table analysis in
Excel, then the same kind of business questions re-answered in SQL.
🛠️ Tech Stack & Tools
Excel: Data cleaning, pivot tables, RANK + VLOOKUP summary tables, slicers
SQL: Filtering, aggregate functions, GROUP BY, subqueries, sorting/ranking
📊 Dataset
168,030 raw product listings scraped from Myntra, across 3,195 unique brands — includes
product name, brand, rating, rating count, marked price, discounted price, and category.
---
Part 1 — Excel
Cleaning pipeline:
`RAW DATA` (168,030 rows) → cleaned down to `CLEAN DATA TABLE` (146,436 rows), removing
invalid/incomplete listings
Built a brand-level summary table (`CLEAN DATA`, 2,371 rows — one row per unique brand)
using `RANK` to rank brands by total revenue, then `VLOOKUP` to pull each brand's summary
row — a compact table for brand-level pivot analysis
Built multiple pivot tables (with slicers) across brand, category, and rating dimensions
Key findings (from the pivot tables):
Top brands by revenue: Veet (₹61.9L), Envy (₹45.2L), MINI (₹43.4L), Ishin (₹39.9L), Bio Oil (₹39.8L)
Top categories by revenue: Perfume & Body Mist (₹1.47Cr), Kurta Sets (₹1.30Cr), Dresses (₹1.26Cr), Watches (₹1.16Cr), Kurtas (₹81.3L)
Before cleaning: avg marked price ₹2,509, avg discounted price ₹1,515, price range ₹50–₹113,999
Note: the ₹113,999 max price and several extreme outliers were scraping artifacts, not real listings — flagged during cleaning
(A dashboard sheet is also included in the workbook as practice — not a core deliverable of this analysis.)
Part 2 — SQL
The same categories of business question, re-answered directly in SQL — see `myntra_analysis.sql`:
Brand and category revenue rankings
Most/least expensive brands, on average and at the extremes
Discount analysis (₹ amount and % discount per product)
Subquery-based lookups (e.g., cheapest product's full details in one query)
Sorting and ranking with `LIMIT`/`OFFSET` (e.g., 2nd most expensive product, worst-rated products with a meaningful review volume)
---
📈 Key Insights (combined)
Revenue is concentrated in a small number of high-performing brands and categories — the top 5 brands by revenue span multiple unrelated product types (beauty, fashion, grooming), suggesting brand strength matters more than category alone.
Perfume & Body Mist and Kurta Sets are the two strongest-performing categories by revenue.
A meaningful share of the raw dataset (~13%) was invalid or junk data, underscoring the importance of a proper cleaning pass before any pivot or SQL analysis.
🚀 How to Use This Repo
Open `data_csv_myntra_data_Copy.xlsx` in Excel to explore the cleaning steps and pivot tables directly.
Run `myntra_analysis.sql` against a MySQL instance with the `PRODUCTS` table loaded from the same dataset.
