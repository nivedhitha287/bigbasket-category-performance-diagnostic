# AI Prompt History Log (`ai_log.md`)

## Prompt #1: SQL Query Diagnostic & Tier Logic (Part 1)

* **Role (R):** Data Analyst & SQL Specialist.
* **Context (C):** Analyzing BigBasket monthly category performance data (Jan–Jun 2026).
* **Task (T):** Draft SQL queries to compute total revenue, delivered order counts, AOV, and performance tier categorization (Above Target, Watch, Critical).
* **Constraint (C):** Standard ANSI SQL syntax compatible with SQLite, structured into distinct operational tiers.
* **Format (F):** Executable SQL script with inline commentary (`query_part1.sql`).

### Concrete Verification Performed:
Executed `query_part1.sql` against `bigbasket_capstone.db` in SQLite and verified that total overall revenue equaled ₹88,282.00 across 434 delivered orders, perfectly matching manual calculations in `workbook_part2.xlsx`.

---

## Prompt #2: Pandas IQR Outlier Capping & Validation Logic (Part 4)

* **Role (R):** Senior Data Engineer & Python/Pandas Specialist.
* **Context (C):** Working on Part 4 of the BigBasket category performance diagnostic dataset (`orders_raw.csv`).
* **Task (T):** Write a Pandas code snippet to compute the IQR upper fence on Delivered `amount_inr` values and cap values above the upper fence using `.clip()`.
* **Constraint (C):** Maintain original row indices, exclude missing values during quantile computation, and apply `.clip(upper=...)` strictly to `amount_inr`.
* **Format (F):** Executable Python code block with step-by-step commentary (`analysis.ipynb`).

### Concrete Verification Performed:
Re-ran `.clip()` logic in `analysis.ipynb` and confirmed that 16 outlier rows exceeding the upper fence were capped at the exact upper fence value, while non-outlier rows remained unchanged and the cleaned order count stood at 500 rows.