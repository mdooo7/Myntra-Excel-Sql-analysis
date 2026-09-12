# Myntra Product Analysis — Excel + SQL

A two-part analysis of a Myntra product listings dataset: cleaning and pivot-table analysis in **Excel**, followed by solving identical core business queries directly using **SQL**.

## 🛠️ Tech Stack & Tools
* **Excel:** Data cleaning, Pivot Tables, `RANK` + `VLOOKUP` summary rollups, Interactive Slicers
* **SQL:** Filtering, Aggregate Functions (`SUM`, `AVG`, `COUNT`), `GROUP BY`, Subqueries, Sorting & Ranking (`LIMIT`/`OFFSET`)

## 📊 Dataset Overview
The project processes **168,030 raw product listings** scraped from Myntra, spanning 3,195 initial brands. The attributes include *Product Name, Brand, Rating, Rating Count, Marked Price, Discounted Price, and Category*.

---

## 📈 Key Dashboard Preview
Below is the top-level analytical sheet showing key metrics driven by a dynamic brand selection filter:

![Brand Performance Dashboard](screenshots/brand-performance-dashboard.png)

---

## 📁 Repository Structure
```text
myntra-excel-sql-analysis/
├── README.md
├── myntra_analysis.sql
├── screenshots/
│   └── brand-performance-dashboard.png
└── data/
    └── myntra_data_cleaning_and_pivots.xlsx
```

---

## 🔍 Deep Dive: Part 1 — Excel
### Data Cleaning Pipeline
1. **`RAW DATA` (168,030 rows):** The initial messy dataset. Outliers like a ₹113,999 maximum price and several extreme entries were flagged as scraping artifacts rather than real store listings.
2. **`CLEAN DATA TABLE` (146,436 rows):** Cleaned product-level dataset after removing junk, incomplete, and highly invalid rows (~13% data reduction).
3. **`CLEAN DATA` (2,371 rows):** A brand-level rollup table. Calculated the total revenue per brand, used `RANK` to order them, and applied `VLOOKUP` to extract **one non-repeated summary row per unique brand**. This created a highly efficient base for brand summary reports.

### Key Excel Metrics (via Pivot Tables)
* **Top Brands by Revenue:** Veet (₹61.9L), Envy (₹45.2L), MINI (₹43.4L), Ishin (₹39.9L), Bio Oil (₹39.8L).
* **Top Categories by Revenue:** Perfume & Body Mist (₹1.47Cr), Kurta Sets (₹1.30Cr), Dresses (₹1.26Cr), Watches (₹1.16Cr), Kurtas (₹81.3L).
* **Pre-cleaning Metrics:** Average Marked Price: ₹2,509 | Average Discounted Price: ₹1,515 | Price Range: ₹50–₹113,999.

---

## 💻 Deep Dive: Part 2 — SQL
The business questions solved in Excel were re-answered with precision queries directly inside `myntra_analysis.sql`:
* **Revenue Performance:** High-level ranking workflows for both brands and categories.
* **Pricing Extremes:** In-depth query analysis for most/least expensive brands on average.
* **Discount Tracking:** Absolute value vs. percentage discount margins per product.
* **Subqueries:** Isolating full item details for the absolute cheapest products in a single run.
* **Advanced Sorting:** Identifying the Nth most expensive product and isolating low-rated products containing a meaningful volume of reviews using `LIMIT` and `OFFSET`.

---

## 💡 Key Insights
* **Brand Power Over Category:** Revenue is heavily concentrated in a small number of top-performing brands. The top 5 brands span unrelated sectors (beauty, fashion, grooming), proving that brand strength drives revenue more than category alone.
* **Core Drivers:** *Perfume & Body Mist* and *Kurta Sets* stand out as the two strongest revenue-generating categories in the entire dataset.
* **The Importance of Data Quality:** Over 13% of the initial dataset consisted of junk rows. Running a data-cleaning pass was absolutely vital before performing any downstream Pivot or SQL operations to prevent highly skewed insights.

---

## 🚀 How to Use This Repo
1. **Excel Exploration:** Download and open `data/myntra_data_cleaning_and_pivots.xlsx` to review the formulas, cleaning steps, structural pivots, and active slicers.
2. **SQL Replication:** Run the scripts inside `myntra_analysis.sql` against a SQL instance containing the `PRODUCTS` table populated with the source dataset.
