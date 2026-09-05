# 🛒 BigBasket Category Performance Diagnostic (Jan–Jun 2026)

👉 **Live Tableau Dashboard:** [View Interactive Dashboard on Tableau Public](https://public.tableau.com/views/BigBasketCategoryPerformanceDiagnostic_17885959685950/Dashboard2?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 📌 Executive Summary
This repository contains an **end-to-end operational diagnostic** analyzing BigBasket’s category-level retail performance across the first half of 2026 (Jan–Jun). The primary objective is to evaluate overall revenue performance, track delivered order volumes, calculate Average Order Value (AOV), and classify product categories into actionable operational performance tiers (**Above Target**, **Watch**, and **Critical**).

The analytical pipeline spans **four integrated methodologies**:
1. **Part 1 (SQL):** Aggregation pipelines, AOV computation, and tier classification logic.
2. **Part 2 (Excel):** Financial cross-validation model and tier checks.
3. **Part 3 (Tableau):** Interactive executive dashboards featuring category metrics, city performance, and monthly revenue trends.
4. **Part 4 (Python/Pandas):** Raw transactional data cleaning, deduplication, IQR outlier capping, supplier merging, and programmatic validation.

---

## 🔗 Project Key Artifacts

* 📊 **Live Interactive Dashboard:** [Tableau Public Dashboard](https://public.tableau.com/views/BigBasketCategoryPerformanceDiagnostic_17885959685950/Dashboard2?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
* 📖 **Strategic Business Narrative:** [DATA_STORY.md](./DATA_STORY.md)
* 🐍 **Python Analytical Notebook:** [analysis.ipynb](./analysis.ipynb)
* 🤖 **AI Audit & Prompt History Log:** [ai_log.md](./ai_log.md)

---

## 📈 High-Level Performance KPIs

| Metric | Validated Output | Operational Target | Performance Status |
| :--- | :---: | :---: | :---: |
| **Total Revenue** | **₹88,282.00** | ₹90,000.00 | 🟡 Near Target (98.1%) |
| **Total Delivered Orders** | **434** | 450 | 🟡 96.4% Order Fulfillment |
| **Average Order Value (AOV)** | **₹203.41** | ₹200.00 | 🟢 Met Target (+1.7%) |
| **Top Category** | **Household Essentials** | — | 🟢 Highest Revenue Anchor |
| **Top Supplier** | **HomeEssentials Traders** | — | 🟢 Key Strategic Partner |
| **Category Target Met** | **3 / 6 Categories** | 6 / 6 | 🔴 50% Underperforming |

---

## 🛠️ Technical Architecture & Pipeline

### 1. SQL Database Processing (`query_part1.sql`)
* Aggregates revenue and order counts filtered strictly by `status = 'Delivered'`.
* Computes Average Order Value ($AOV = \frac{\text{Total Revenue}}{\text{Delivered Orders}}$).
* Implements SQL `CASE` expressions to dynamically categorize performance into operational tiers based on target revenue thresholds.

### 2. Excel Modeling & Verification (`workbook_part2.xlsx`)
* Replicates SQL tiering logic using Excel formulas (`SUMIFS`, `COUNTIFS`, nested `IF`).
* Serves as an independent audit layer to verify mathematical consistency before dashboard ingestion.

### 3. Tableau Dashboard Development (Part 3)
* Features an executive KPI summary card row displaying total revenue, orders, and AOV.
* Provides monthly trend line charts and category revenue bar charts with performance tier color encoding.
* Incorporates interactive filtering by City and Category to enable detailed diagnostic drill-downs.

### 4. Python/Pandas Data Diagnostic (`analysis.ipynb`)
* **Deduplication:** Identified and eliminated 8 synthetic duplicate rows from 508 raw entries, confirming exactly 500 clean order records.
* **Text Normalization:** Standardized mixed casing and whitespace across categorical fields (`city` and `category`).
* **Outlier Capping:** Applied Interquartile Range (IQR) fence calculations ($Q3 + 1.5 \times IQR$) and capped revenue spikes using `.clip()` to prevent extreme value distortion.
* **Cross-Validation:** Merged clean order data with catalog tables (`products.csv`) to verify that top category and supplier metrics perfectly matched SQL outputs.

---

##  Repository Structure

```text
├── analysis.ipynb                # Python/Pandas data cleaning, IQR capping & visualizations
├── ai_log.md                     # Structured RCTCF prompt engineering & validation audit
├── DATA_STORY.md                 # Strategic findings, root-cause analysis & action plan
├── query_part1.sql               # Production SQL queries (Aggregations, AOV & Tier logic)
├── workbook_part2.xlsx           # Financial validation model & manual tier checks
├── monthly_category_revenue.csv  # Core diagnostic source dataset (Jan–Jun 2026)
├── orders_raw.csv                # Raw, uncleaned transactional order dataset
├── products.csv                  # Master catalog mapping products to suppliers
├── generate_data.py              # Synthetic data engine and SQLite DB setup
├── schema.sql                    # Relational database table definitions
└── README.md                     # Master project overview and documentation
