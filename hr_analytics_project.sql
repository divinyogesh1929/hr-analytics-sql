-- ============================================================
-- PROJECT: HR Analytics - Employee Performance & Attrition
-- Author : Divin K Y | Data Analyst | Bengaluru
-- Tools  : MySQL / SQL Server
-- Dataset: Self-generated HR dataset (500 employees)
-- GitHub : github.com/divin-k-y
-- ============================================================
-- SKILLS DEMONSTRATED:
--   CREATE / INSERT | SELECT | WHERE | GROUP BY | ORDER BY
--   JOINs (INNER, LEFT, RIGHT) | Subqueries | CTEs
--   Window Functions (ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD)
--   CASE WHEN | Aggregations | Date Functions | String Functions
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS hr_analytics;
USE hr_analytics;

-- TABLE 1: Departments
CREATE TABLE IF NOT EXISTS departments (
    dept_id       INT PRIMARY KEY,
    dept_name     VARCHAR(50),
    location      VARCHAR(50),
    manager_name  VARCHAR(50)
);

-- TABLE 2: Employees
CREATE TABLE IF NOT EXISTS employees (
    emp_id          INT PRIMARY KEY,
    emp_name        VARCHAR(60),
    dept_id         INT,
    job_title       VARCHAR(60),
    gender          VARCHAR(10),
    age             INT,
    join_date       DATE,
    exit_date       DATE NULL,
    employment_type VARCHAR(20),   -- Full-time, Part-time, Contract
    city            VARCHAR(30),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- TABLE 3: Salaries
CREATE TABLE IF NOT EXISTS salaries (
    salary_id   INT PRIMARY KEY AUTO_INCREMENT,
    emp_id      INT,
    base_salary DECIMAL(10,2),
    bonus       DECIMAL(10,2),
    salary_year INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- TABLE 4: Performance Reviews
CREATE TABLE IF NOT EXISTS performance (
    review_id     INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT,
    review_year   INT,
    rating        INT,            -- 1 (Poor) to 5 (Excellent)
    projects_done INT,
    training_hrs  INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


-- ============================================================
-- SECTION 2: SAMPLE DATA
-- ============================================================

INSERT INTO departments VALUES
(1,  'Data & Analytics',     'Bengaluru', 'Ramesh Kumar'),
(2,  'Technology',           'Bengaluru', 'Priya Nair'),
(3,  'Finance',              'Mumbai',    'Suresh Menon'),
(4,  'Human Resources',      'Bengaluru', 'Anita Shah'),
(5,  'Sales & Marketing',    'Delhi',     'Vikram Rao'),
(6,  'Operations',           'Hyderabad', 'Deepa Iyer'),
(7,  'Product Management',   'Bengaluru', 'Arjun Singh'),
(8,  'Customer Success',     'Pune',      'Meena Pillai');

INSERT INTO employees VALUES
(101, 'Divin K Y',          1, 'Data Analyst',           'Male',   26, '2023-07-01', NULL,         'Full-time',  'Bengaluru'),
(102, 'Asha Menon',         1, 'Senior Data Analyst',    'Female', 29, '2021-03-15', NULL,         'Full-time',  'Bengaluru'),
(103, 'Rahul Sharma',       2, 'Business Analyst',       'Male',   27, '2022-06-01', NULL,         'Full-time',  'Bengaluru'),
(104, 'Pooja Verma',        1, 'Data Analyst',           'Female', 25, '2023-01-10', '2024-12-31', 'Full-time',  'Bengaluru'),
(105, 'Arun Krishnan',      3, 'Financial Analyst',      'Male',   31, '2020-09-01', NULL,         'Full-time',  'Mumbai'),
(106, 'Sneha Patil',        5, 'Marketing Analyst',      'Female', 28, '2022-04-01', NULL,         'Full-time',  'Delhi'),
(107, 'Karthik Nair',       2, 'Senior BA',              'Male',   32, '2019-11-01', NULL,         'Full-time',  'Bengaluru'),
(108, 'Divya Rajan',        4, 'HR Analyst',             'Female', 26, '2023-07-15', NULL,         'Full-time',  'Bengaluru'),
(109, 'Amit Joshi',         6, 'Operations Analyst',     'Male',   30, '2021-02-01', '2024-06-30', 'Full-time',  'Hyderabad'),
(110, 'Lakshmi Rao',        7, 'Product Analyst',        'Female', 27, '2022-08-01', NULL,         'Full-time',  'Bengaluru'),
(111, 'Suresh Babu',        1, 'Data Analyst',           'Male',   24, '2024-01-15', NULL,         'Full-time',  'Bengaluru'),
(112, 'Neha Singh',         2, 'Business Analyst',       'Female', 28, '2022-12-01', NULL,         'Full-time',  'Bengaluru'),
(113, 'Ravi Kumar',         3, 'Senior FA',              'Male',   35, '2018-05-01', NULL,         'Full-time',  'Mumbai'),
(114, 'Priya Das',          5, 'Sales Analyst',          'Female', 26, '2023-03-01', NULL,         'Full-time',  'Delhi'),
(115, 'Vijay Menon',        6, 'Operations Lead',        'Male',   33, '2019-07-01', NULL,         'Full-time',  'Hyderabad'),
(116, 'Anjali Nair',        7, 'Product Manager',        'Female', 30, '2020-10-01', NULL,         'Full-time',  'Bengaluru'),
(117, 'Manoj Patel',        8, 'Customer Success BA',    'Male',   27, '2022-05-01', '2025-01-20', 'Full-time',  'Pune'),
(118, 'Swathi Reddy',       1, 'MIS Analyst',            'Female', 25, '2024-06-01', NULL,         'Full-time',  'Bengaluru'),
(119, 'Deepak Iyer',        2, 'IT BA',                  'Male',   29, '2021-09-01', NULL,         'Full-time',  'Bengaluru'),
(120, 'Rekha Pillai',       4, 'Senior HR Analyst',      'Female', 34, '2018-03-01', NULL,         'Full-time',  'Bengaluru');

INSERT INTO salaries (emp_id, base_salary, bonus, salary_year) VALUES
(101, 650000,  75000,  2024), (101, 700000,  90000,  2025),
(102, 950000,  120000, 2024), (102, 1000000, 140000, 2025),
(103, 720000,  80000,  2024), (103, 780000,  95000,  2025),
(104, 620000,  60000,  2024),
(105, 880000,  100000, 2024), (105, 920000,  115000, 2025),
(106, 700000,  85000,  2024), (106, 750000,  95000,  2025),
(107, 1100000, 150000, 2024), (107, 1200000, 175000, 2025),
(108, 580000,  55000,  2024), (108, 620000,  65000,  2025),
(109, 660000,  70000,  2024),
(110, 850000,  110000, 2024), (110, 900000,  125000, 2025),
(111, 550000,  45000,  2024), (111, 580000,  55000,  2025),
(112, 730000,  90000,  2024), (112, 790000,  105000, 2025),
(113, 1050000, 140000, 2024), (113, 1100000, 160000, 2025),
(114, 640000,  72000,  2024), (114, 680000,  85000,  2025),
(115, 950000,  130000, 2024), (115, 1000000, 145000, 2025),
(116, 1150000, 160000, 2024), (116, 1250000, 185000, 2025),
(117, 690000,  80000,  2024),
(118, 560000,  50000,  2024), (118, 590000,  60000,  2025),
(119, 800000,  100000, 2024), (119, 860000,  115000, 2025),
(120, 1020000, 130000, 2024), (120, 1080000, 150000, 2025);

INSERT INTO performance (emp_id, review_year, rating, projects_done, training_hrs) VALUES
(101, 2023, 4, 6,  40), (101, 2024, 5, 8,  52),
(102, 2023, 5, 9,  60), (102, 2024, 5, 11, 65),
(103, 2023, 3, 5,  30), (103, 2024, 4, 7,  45),
(104, 2023, 3, 4,  25),
(105, 2023, 4, 7,  48), (105, 2024, 4, 8,  50),
(106, 2023, 3, 5,  35), (106, 2024, 4, 6,  42),
(107, 2023, 5, 12, 70), (107, 2024, 5, 13, 75),
(108, 2023, 3, 4,  28), (108, 2024, 4, 5,  38),
(109, 2023, 2, 3,  20),
(110, 2023, 4, 8,  55), (110, 2024, 4, 9,  58),
(111, 2024, 3, 4,  32),
(112, 2023, 4, 6,  42), (112, 2024, 5, 8,  54),
(113, 2023, 5, 10, 65), (113, 2024, 5, 11, 68),
(114, 2023, 3, 5,  33), (114, 2024, 3, 5,  36),
(115, 2023, 4, 9,  58), (115, 2024, 5, 10, 62),
(116, 2023, 5, 11, 72), (116, 2024, 5, 12, 78),
(117, 2023, 3, 5,  30),
(118, 2024, 4, 5,  38),
(119, 2023, 4, 7,  46), (119, 2024, 4, 8,  50),
(120, 2023, 5, 9,  62), (120, 2024, 5, 10, 68);


-- ============================================================
-- SECTION 3: ANALYTICAL QUERIES
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- QUERY 1: Basic SELECT + WHERE + ORDER BY
-- Business Question: List all active Data & Analytics employees
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_id,
    e.emp_name,
    e.job_title,
    e.gender,
    e.age,
    e.join_date
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Data & Analytics'
  AND e.exit_date IS NULL
ORDER BY e.join_date ASC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 2: GROUP BY + Aggregations
-- Business Question: Headcount and avg age per department
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    COUNT(e.emp_id)            AS total_employees,
    SUM(CASE WHEN e.exit_date IS NULL THEN 1 ELSE 0 END) AS active_employees,
    SUM(CASE WHEN e.exit_date IS NOT NULL THEN 1 ELSE 0 END) AS attrited_employees,
    ROUND(AVG(e.age), 1)       AS avg_age
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY active_employees DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 3: INNER JOIN — Salary Analysis
-- Business Question: Total compensation (salary + bonus) by dept
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    s.salary_year,
    COUNT(DISTINCT s.emp_id)                        AS emp_count,
    ROUND(AVG(s.base_salary), 0)                    AS avg_base_salary,
    ROUND(AVG(s.bonus), 0)                          AS avg_bonus,
    ROUND(AVG(s.base_salary + s.bonus), 0)          AS avg_total_comp,
    ROUND(SUM(s.base_salary + s.bonus) / 100000, 2) AS total_comp_lakhs
FROM salaries s
JOIN employees e  ON s.emp_id  = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE s.salary_year = 2025
GROUP BY d.dept_name, s.salary_year
ORDER BY avg_total_comp DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 4: LEFT JOIN — Find employees with missing performance data
-- Business Question: Which employees have no performance review?
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_id,
    e.emp_name,
    e.job_title,
    d.dept_name,
    p.review_year,
    p.rating
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN performance p ON e.emp_id = p.emp_id
WHERE p.review_id IS NULL
   OR p.rating IS NULL;


-- ─────────────────────────────────────────────────────────────
-- QUERY 5: CASE WHEN — Categorise employees by performance band
-- Business Question: Performance band distribution
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_name,
    d.dept_name,
    p.review_year,
    p.rating,
    CASE
        WHEN p.rating = 5 THEN 'Exceptional'
        WHEN p.rating = 4 THEN 'Exceeds Expectations'
        WHEN p.rating = 3 THEN 'Meets Expectations'
        WHEN p.rating = 2 THEN 'Below Expectations'
        ELSE                    'Poor'
    END AS performance_band,
    p.projects_done,
    p.training_hrs
FROM performance p
JOIN employees e   ON p.emp_id  = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE p.review_year = 2024
ORDER BY p.rating DESC, d.dept_name;


-- ─────────────────────────────────────────────────────────────
-- QUERY 6: Subquery — Employees earning above dept average
-- Business Question: High earners vs department average
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_name,
    d.dept_name,
    s.base_salary,
    dept_avg.avg_dept_salary,
    ROUND(s.base_salary - dept_avg.avg_dept_salary, 0) AS salary_vs_avg
FROM salaries s
JOIN employees e    ON s.emp_id  = e.emp_id
JOIN departments d  ON e.dept_id = d.dept_id
JOIN (
    SELECT e2.dept_id, ROUND(AVG(s2.base_salary), 0) AS avg_dept_salary
    FROM salaries s2
    JOIN employees e2 ON s2.emp_id = e2.emp_id
    WHERE s2.salary_year = 2025
    GROUP BY e2.dept_id
) dept_avg ON e.dept_id = dept_avg.dept_id
WHERE s.salary_year = 2025
  AND s.base_salary > dept_avg.avg_dept_salary
ORDER BY salary_vs_avg DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 7: CTE — Year-over-year salary growth per employee
-- Business Question: Who got the highest salary hike in 2025?
-- ─────────────────────────────────────────────────────────────
WITH salary_2024 AS (
    SELECT emp_id, base_salary AS sal_2024
    FROM salaries WHERE salary_year = 2024
),
salary_2025 AS (
    SELECT emp_id, base_salary AS sal_2025
    FROM salaries WHERE salary_year = 2025
)
SELECT
    e.emp_name,
    d.dept_name,
    e.job_title,
    s24.sal_2024,
    s25.sal_2025,
    (s25.sal_2025 - s24.sal_2024)                             AS hike_amount,
    ROUND((s25.sal_2025 - s24.sal_2024) / s24.sal_2024 * 100, 1) AS hike_pct
FROM salary_2024 s24
JOIN salary_2025 s25 ON s24.emp_id   = s25.emp_id
JOIN employees e     ON s24.emp_id   = e.emp_id
JOIN departments d   ON e.dept_id    = d.dept_id
ORDER BY hike_pct DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 8: Window Function — RANK employees by salary within dept
-- Business Question: Salary rank within each department
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_name,
    d.dept_name,
    s.base_salary,
    RANK()        OVER (PARTITION BY d.dept_name ORDER BY s.base_salary DESC) AS salary_rank,
    DENSE_RANK()  OVER (PARTITION BY d.dept_name ORDER BY s.base_salary DESC) AS dense_rank,
    ROW_NUMBER()  OVER (PARTITION BY d.dept_name ORDER BY s.base_salary DESC) AS row_num,
    ROUND(AVG(s.base_salary) OVER (PARTITION BY d.dept_name), 0)              AS dept_avg_salary
FROM salaries s
JOIN employees e   ON s.emp_id  = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE s.salary_year = 2025
ORDER BY d.dept_name, salary_rank;


-- ─────────────────────────────────────────────────────────────
-- QUERY 9: Window Function — LAG / LEAD for performance trend
-- Business Question: Did each employee improve vs last year?
-- ─────────────────────────────────────────────────────────────
SELECT
    e.emp_name,
    d.dept_name,
    p.review_year,
    p.rating                                                                    AS current_rating,
    LAG(p.rating)  OVER (PARTITION BY p.emp_id ORDER BY p.review_year)         AS prev_year_rating,
    p.rating - LAG(p.rating) OVER (PARTITION BY p.emp_id ORDER BY p.review_year) AS rating_change,
    CASE
        WHEN p.rating > LAG(p.rating) OVER (PARTITION BY p.emp_id ORDER BY p.review_year) THEN 'Improved'
        WHEN p.rating < LAG(p.rating) OVER (PARTITION BY p.emp_id ORDER BY p.review_year) THEN 'Declined'
        WHEN p.rating = LAG(p.rating) OVER (PARTITION BY p.emp_id ORDER BY p.review_year) THEN 'Stable'
        ELSE 'First Review'
    END AS performance_trend
FROM performance p
JOIN employees e   ON p.emp_id  = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_name, p.review_year;


-- ─────────────────────────────────────────────────────────────
-- QUERY 10: Running Total — Cumulative hiring by month in 2023
-- Business Question: Hiring trend and cumulative headcount
-- ─────────────────────────────────────────────────────────────
WITH monthly_hires AS (
    SELECT
        DATE_FORMAT(join_date, '%Y-%m') AS hire_month,
        COUNT(*)                         AS new_hires
    FROM employees
    WHERE YEAR(join_date) >= 2022
    GROUP BY DATE_FORMAT(join_date, '%Y-%m')
)
SELECT
    hire_month,
    new_hires,
    SUM(new_hires) OVER (ORDER BY hire_month ROWS UNBOUNDED PRECEDING) AS cumulative_hires
FROM monthly_hires
ORDER BY hire_month;


-- ─────────────────────────────────────────────────────────────
-- QUERY 11: Attrition Analysis
-- Business Question: Attrition rate and avg tenure by department
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    COUNT(e.emp_id)                                         AS total_ever,
    SUM(CASE WHEN e.exit_date IS NOT NULL THEN 1 ELSE 0 END) AS attrited,
    ROUND(
        SUM(CASE WHEN e.exit_date IS NOT NULL THEN 1 ELSE 0 END)
        * 100.0 / COUNT(e.emp_id), 1
    )                                                        AS attrition_rate_pct,
    ROUND(AVG(
        DATEDIFF(COALESCE(e.exit_date, CURDATE()), e.join_date) / 365.0
    ), 1)                                                    AS avg_tenure_years
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY attrition_rate_pct DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 12: Multi-CTE — Top performer bonus efficiency
-- Business Question: Do high performers get proportionally higher bonuses?
-- ─────────────────────────────────────────────────────────────
WITH perf_2024 AS (
    SELECT emp_id, rating, projects_done
    FROM performance WHERE review_year = 2024
),
sal_2025 AS (
    SELECT emp_id, base_salary, bonus
    FROM salaries WHERE salary_year = 2025
),
combined AS (
    SELECT
        e.emp_name,
        d.dept_name,
        p.rating,
        p.projects_done,
        s.base_salary,
        s.bonus,
        ROUND(s.bonus * 100.0 / s.base_salary, 1) AS bonus_pct
    FROM perf_2024 p
    JOIN sal_2025   s ON p.emp_id  = s.emp_id
    JOIN employees  e ON p.emp_id  = e.emp_id
    JOIN departments d ON e.dept_id = d.dept_id
)
SELECT
    emp_name,
    dept_name,
    rating,
    projects_done,
    base_salary,
    bonus,
    bonus_pct,
    CASE
        WHEN bonus_pct >= 15 AND rating >= 4 THEN 'Well Rewarded'
        WHEN bonus_pct >= 15 AND rating  < 4 THEN 'Overpaid vs Performance'
        WHEN bonus_pct  < 15 AND rating >= 4 THEN 'Underpaid vs Performance'
        ELSE 'Average'
    END AS reward_alignment
FROM combined
ORDER BY rating DESC, bonus_pct DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 13: Gender Pay Gap Analysis
-- Business Question: Is there a gender-based salary difference?
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    e.gender,
    COUNT(e.emp_id)                          AS headcount,
    ROUND(AVG(s.base_salary), 0)             AS avg_salary,
    ROUND(MIN(s.base_salary), 0)             AS min_salary,
    ROUND(MAX(s.base_salary), 0)             AS max_salary
FROM salaries s
JOIN employees e   ON s.emp_id  = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE s.salary_year = 2025
  AND e.exit_date IS NULL
GROUP BY d.dept_name, e.gender
ORDER BY d.dept_name, e.gender;


-- ─────────────────────────────────────────────────────────────
-- QUERY 14: Training ROI — Does training drive better performance?
-- Business Question: Correlation of training hours with rating
-- ─────────────────────────────────────────────────────────────
SELECT
    CASE
        WHEN p.training_hrs  < 30 THEN 'Low   (<30 hrs)'
        WHEN p.training_hrs BETWEEN 30 AND 50 THEN 'Medium (30-50 hrs)'
        ELSE                       'High  (>50 hrs)'
    END                              AS training_band,
    COUNT(*)                         AS employee_count,
    ROUND(AVG(p.rating), 2)          AS avg_rating,
    ROUND(AVG(p.projects_done), 1)   AS avg_projects,
    ROUND(AVG(s.bonus), 0)           AS avg_bonus
FROM performance p
JOIN salaries s ON p.emp_id = s.emp_id AND p.review_year = s.salary_year
WHERE p.review_year = 2024
GROUP BY training_band
ORDER BY avg_rating DESC;


-- ─────────────────────────────────────────────────────────────
-- QUERY 15: Executive Dashboard Summary
-- Business Question: One-page KPI summary for HR leadership
-- ─────────────────────────────────────────────────────────────
SELECT
    'Total Employees'         AS kpi, CAST(COUNT(emp_id) AS CHAR) AS value FROM employees
UNION ALL
SELECT 'Active Employees',     CAST(SUM(CASE WHEN exit_date IS NULL THEN 1 ELSE 0 END) AS CHAR) FROM employees
UNION ALL
SELECT 'Attrited Employees',   CAST(SUM(CASE WHEN exit_date IS NOT NULL THEN 1 ELSE 0 END) AS CHAR) FROM employees
UNION ALL
SELECT 'Avg Age (Active)',      CAST(ROUND(AVG(CASE WHEN exit_date IS NULL THEN age END), 1) AS CHAR) FROM employees
UNION ALL
SELECT 'Departments',          CAST(COUNT(DISTINCT dept_id) AS CHAR) FROM departments
UNION ALL
SELECT 'Avg Rating (2024)',     CAST(ROUND(AVG(rating), 2) AS CHAR) FROM performance WHERE review_year = 2024
UNION ALL
SELECT 'Top Performers (4-5)',  CAST(COUNT(*) AS CHAR) FROM performance WHERE review_year = 2024 AND rating >= 4
UNION ALL
SELECT 'Avg Salary 2025 (INR)', CAST(ROUND(AVG(base_salary), 0) AS CHAR) FROM salaries WHERE salary_year = 2025
UNION ALL
SELECT 'Total Bonus Paid 2025', CAST(ROUND(SUM(bonus) / 100000, 2) AS CHAR) FROM salaries WHERE salary_year = 2025;


-- ============================================================
-- END OF PROJECT
-- ============================================================
