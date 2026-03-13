# 📊 HR Analytics — Employee Performance & Attrition (SQL Project)

**Author:** Divin K Y | Data Analyst | Bengaluru  
**Tools:** MySQL / SQL Server  
**Skills:** SQL JOINs • CTEs • Window Functions • Subqueries • Aggregations • CASE WHEN

---

## 🎯 Project Objective

Analyse a fictional HR dataset of 500 employees across 8 departments to answer real business questions around performance, attrition, salary benchmarking, and training effectiveness — using pure SQL.

---

## 📁 Files

| File | Description |
|------|-------------|
| `hr_analytics_project.sql` | Full project: CREATE, INSERT, 15 analytical queries |

---

## 🗂️ Database Schema

```
departments  →  dept_id, dept_name, location, manager_name
employees    →  emp_id, emp_name, dept_id, job_title, gender, age, join_date, exit_date
salaries     →  salary_id, emp_id, base_salary, bonus, salary_year
performance  →  review_id, emp_id, review_year, rating, projects_done, training_hrs
```

---

## 🔍 Business Questions Answered (15 Queries)

| # | Business Question | SQL Concept |
|---|---|---|
| 1 | List active employees in Data & Analytics team | SELECT, WHERE, JOIN |
| 2 | Headcount & avg age per department | GROUP BY, COUNT, AVG |
| 3 | Total compensation by department (2025) | Multi-table JOIN, SUM |
| 4 | Employees with missing performance data | LEFT JOIN, NULL check |
| 5 | Categorise employees into performance bands | CASE WHEN |
| 6 | Employees earning above department average | Subquery |
| 7 | Year-over-year salary growth per employee | CTE, % calculation |
| 8 | Salary rank within each department | RANK, DENSE_RANK, ROW_NUMBER, Window |
| 9 | Performance improvement/decline trend | LAG, LEAD, Window Functions |
| 10 | Cumulative hiring trend by month | CTE + Running Total Window |
| 11 | Attrition rate & avg tenure by department | DATEDIFF, COALESCE |
| 12 | Bonus reward vs performance alignment | Multi-CTE, CASE WHEN |
| 13 | Gender pay gap analysis per department | GROUP BY, MIN/MAX/AVG |
| 14 | Training ROI — does training drive better ratings? | Bucketing, JOIN across tables |
| 15 | Executive HR KPI dashboard | UNION ALL |

---

## 💡 Key Findings

- **Data & Analytics** department has the highest avg salary at Rs. 9.26 LPA
- Employees with **rating 4–5** completed 2x more projects than low performers
- **Year 1 employees** show highest attrition risk across all departments
- Training above **50 hours** correlates with 0.8 higher average performance rating
- ~30% of high performers are **underpaid vs department average** — a retention risk

---

## 🚀 How to Run

```sql
-- 1. Open MySQL Workbench or SQL Server Management Studio
-- 2. Run the full file:
SOURCE hr_analytics_project.sql;
-- 3. Each query is clearly labelled — run individually or all at once
```

---

## 📬 Connect

- **LinkedIn:** linkedin.com/in/divin-k-y
- **Email:** divinyogesh10@gmail.com
- **Location:** Bengaluru, Karnataka | Immediate Joiner
