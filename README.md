# HR Analytics — PostgreSQL SQL Project

## 📌 Project Overview

The **HR Analytics SQL Project** is a data analytics project designed to analyze employee data and generate meaningful insights into workforce management, salary distribution, employee attendance, and performance.

The project uses PostgreSQL to perform data analysis through SQL queries, ranging from basic data retrieval to advanced analytical techniques such as Common Table Expressions (CTEs), window functions, self-joins, and employee ranking.

The objective is to demonstrate practical SQL skills and understand how HR data can support data-driven decision-making.

## 🎯 Project Objectives

- Analyze employee demographics and workforce distribution.
- Identify salary trends across departments.
- Evaluate employee performance using review ratings.
- Analyze employee attendance and working hours.
- Track employee hiring trends over time.
- Compare salary growth across employees.
- Build an employee leaderboard using a composite scoring system.

## 🛠️ Tools & Technologies

- **Database:** PostgreSQL
- **Query Language:** SQL
- **Data Format:** CSV
- **Tools:** pgAdmin / PostgreSQL

## 📂 Database Schema

The project consists of five relational tables.

| Table | Description |
|---|---|
| `departments` | Department information, locations, and budgets |
| `employees` | Employee details, job titles, hiring dates, and employment status |
| `salaries` | Employee salary records and salary history |
| `attendance` | Employee attendance records and working hours |
| `performance_reviews` | Employee performance ratings and review details |

### Table Relationships

- Employees belong to departments.
- Employees can have multiple salary records over time.
- Employees can have multiple attendance records.
- Employees can have multiple performance reviews.
- Employees may have managers who are also employees.

## 📊 SQL Analysis

The project contains **30 SQL questions** divided into three difficulty levels.

### Basic Analysis — Q1 to Q10

- Retrieve active employees.
- Filter employees based on hiring dates.
- Analyze employees by department.
- Identify employees based on job titles.
- Retrieve current salary records.
- Count employees by department.
- Filter departments based on employee count.
- Calculate minimum, maximum, and average working hours.
- Analyze employee employment status.
- Identify employees without performance reviews.

### Intermediate Analysis — Q11 to Q20

- Analyze salary distribution across departments.
- Compare employee salaries with department averages.
- Calculate employee tenure.
- Calculate employee attendance rates.
- Analyze average working hours by department.
- Identify employees with high performance ratings.
- Compare historical salary records.
- Analyze recent hiring trends.
- Identify managers and their reporting employees.
- Analyze department performance and review participation.

### Advanced Analysis — Q21 to Q30

- Advanced employee salary analysis.
- Workforce and performance analysis.
- Employee salary history analysis.
- Calculate salary growth and growth percentage.
- Analyze month-over-month hiring trends using `LAG()`.
- Perform advanced employee comparisons.
- Analyze employee performance trends.
- Evaluate workforce metrics using window functions.
- Perform advanced HR analytics.
- Create an HR employee leaderboard using a composite ranking score.

*The exact query statements and outputs are available in the SQL files included in this repository.*

## 🧠 SQL Concepts Practiced

This project demonstrates practical application of the following PostgreSQL concepts:

- `SELECT`, `WHERE`, `ORDER BY`, and `GROUP BY`
- Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
- Filtering grouped data using `HAVING`
- `INNER JOIN`, `LEFT JOIN`, and self-joins
- Common Table Expressions (CTEs)
- Subqueries
- `CASE` expressions
- Window functions
- `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()`
- `LAG()` and `LEAD()`
- `DATE_TRUNC()`
- Aggregate `FILTER` clauses
- Salary growth calculations
- Composite scoring and ranking

## 📈 Key Analytical Areas

### 1. Workforce Analysis

Analyze employee distribution across departments, employment status, job titles, and hiring periods.

### 2. Salary Analysis

Evaluate current salaries, department-level salary averages, historical salary changes, and employee salary growth.

### 3. Attendance Analysis

Calculate employee attendance percentages and analyze working hours to understand workforce attendance patterns.

### 4. Performance Analysis

Evaluate employee performance using review ratings and compare performance across departments.

### 5. Employee Leaderboard

Develop a composite employee ranking based on salary, performance, and attendance.

The composite score is calculated as:

```sql
salary_rank
+ performance_rank
+ attendance_rank
```

Since a lower rank number represents a better position, a lower composite score indicates a stronger overall ranking.

The final leaderboard uses `DENSE_RANK()` to rank employees based on their composite scores.

## 💡 Business Applications

The analysis can help HR teams:

- Understand workforce distribution.
- Identify salary differences across departments.
- Monitor employee attendance.
- Evaluate employee performance.
- Track hiring trends.
- Analyze employee salary progression.
- Compare employees using multiple workforce metrics.

## 📁 Project Structure

```text
HR-Analytics-SQL/
│
├── data/
│   ├── departments.csv
│   ├── employees.csv
│   ├── salaries.csv
│   ├── attendance.csv
│   └── performance_reviews.csv
│
├── sql/
│   ├── 01_basic_queries.sql
│   ├── 02_intermediate_queries.sql
│   └── 03_advanced_queries.sql
│
└── README.md
```

## 🚀 How to Run the Project

1. Install PostgreSQL and pgAdmin.
2. Create a database named `hr_analytics`.
3. Create the five tables using the provided SQL schema.
4. Import the CSV files into their corresponding tables.
5. Open the SQL files in pgAdmin.
6. Execute the queries to reproduce the analysis.

## 📚 Learning Outcomes

Through this project, I strengthened my ability to:

- Write SQL queries for real-world analytical scenarios.
- Analyze relational datasets using joins and aggregations.
- Use window functions for ranking and time-based analysis.
- Work with historical salary records.
- Calculate employee performance and attendance metrics.
- Develop analytical logic for business-oriented problems.

## 👨‍💻 Author

**Ajay Rathod**

B.Tech Computer Engineering | Aspiring Data Analyst

- GitHub: [mrxaj94-sudo](https://github.com/mrxaj94-sudo)
- LinkedIn: [Ajay Rathod](https://www.linkedin.com/)

---

⭐ If you find this project useful, feel free to explore the SQL queries and share your feedback.
