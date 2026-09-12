# Myntra Product Analysis — Excel + SQL

A two-part analysis of a Myntra product listings dataset: cleaning and pivot-table analysis in **Excel**, followed by solving the same core business questions directly in **SQL**.

## 🛠️ Tech Stack & Tools

* **Excel:** Data cleaning, Pivot Tables, `RANK` + `VLOOKUP` summary rollups, interactive slicers
* **SQL:** Filtering, aggregate functions (`SUM`, `AVG`, `COUNT`), `GROUP BY`, subqueries, sorting & ranking (`LIMIT`/`OFFSET`)

## 📊 Dataset Overview

168,030 raw product listings scraped from Myntra, spanning 3,195 unique brands. Attributes include product name, brand, rating, rating count, marked price, discounted price, and category.

---

## 📈 Business Questions → Pivot Tables → Charts

![Business questions answered with pivot tables and charts](screenshots/business-ques-with-pivot-chart.png)

Each business question (e.g. *"Find the most expensive brand,"* *"Top 10 best brands by cumulative revenue"*) was answered directly with a pivot table and matching chart — shown above for the "which category has the highest average discount %" question.

## 📊 Full Brand Performance Dashboard

![Brand performance dashboard with pivot tables and slicer](screenshots/brand-performance-dashboard.png)

A multi-pivot dashboard (revenue, units sold, average rating, price comparison, and discount % — all filterable by brand via a single slicer).

*(The workbook also includes a `FINAL DASHBOARD` sheet built purely as practice — not referenced here as a core deliverable.)*

---

## 🔍 Deep Dive: Part 1 — Excel

### Data Cleaning Pipeline

1. **`RAW DATA`** (168,030 rows) — the initial messy dataset. Outliers like a ₹113,999 maximum price were flagged as scraping artifacts rather than real listings.
2. **`CLEAN DATA TABLE`** (146,436 rows) — cleaned product-level dataset after removing junk, incomplete, and invalid rows (~13% reduction).
3. **`CLEAN DATA`** (2,371 rows) — a brand-level rollup. Ranked brands by total revenue with `RANK`, then used `VLOOKUP` to pull one summary row per unique brand — a compact base for brand-level reporting.

### Key Excel Metrics (via Pivot Tables)

* **Top brands by revenue:** Veet (₹61.9L), Envy (₹45.2L), MINI (₹43.4L), Ishin (₹39.9L), Bio Oil (₹39.8L)
* **Top categories by revenue:** Perfume & Body Mist (₹1.47Cr), Kurta Sets (₹1.30Cr), Dresses (₹1.26Cr), Watches (₹1.16Cr), Kurtas (₹81.3L)
* **Pre-cleaning metrics:** avg marked price ₹2,509 · avg discounted price ₹1,515 · price range ₹50–₹113,999

---

## 💻 Deep Dive: Part 2 — SQL

The same business questions solved in Excel were re-answered with SQL in [`myntra_analysis.sql`](./myntra_analysis.sql):

* **Revenue performance:** ranking workflows for both brands and categories
* **Pricing extremes:** most/least expensive brands, on average and at the extremes
* **Discount tracking:** absolute discount amount vs. discount % per product
* **Subqueries:** isolating full item details for the cheapest product in a single query
* **Advanced sorting:** Nth-most-expensive product, worst-rated products with a meaningful review volume, using `LIMIT`/`OFFSET`

---

## 💡 Key Insights

* **Brand power over category:** revenue is concentrated in a small number of top-performing brands spanning unrelated sectors (beauty, fashion, grooming) — brand strength drives revenue more than category alone.
* **Core drivers:** Perfume & Body Mist and Kurta Sets are the two strongest revenue-generating categories in the dataset.
* **Data quality matters:** over 13% of the raw dataset was junk/invalid — cleaning was essential before any pivot or SQL analysis to avoid skewed results.

---

## 📁 Repository Structure

```text
myntra-excel-sql-analysis/
├── README.md
├── myntra_analysis.sql
├── screenshots/
│   ├── business-ques-with-pivot-chart.png
│   └── brand-performance-dashboard.png
└── data/
    └── myntra_data_cleaning_and_pivots.xlsx
```

---

## 🚀 How to Use This Repo

1. **Excel exploration:** download and open `data/myntra_data_cleaning_and_pivots.xlsx` to review the cleaning steps, pivot tables, and slicers directly.
2. **SQL replication:** run `myntra_analysis.sql` against a MySQL instance with a `PRODUCTS` table populated from the source dataset.
