# 📊 JobPulse — Data Analyst Job Market & Skill Intelligence Platform

## 📌 Project Overview

**JobPulse** is a data analytics project that analyzes Data Analyst job postings to identify the most demanded skills, hiring patterns, experience requirements, locations, and skill combinations in the job market.

The project transforms raw job-posting data into actionable insights using **Python, MySQL, SQL, and Power BI**.

The goal is to help aspiring Data Analysts understand:

* Which skills are most frequently requested by employers
* Which skills are associated with different experience levels
* Which locations have the highest number of job opportunities
* How job-posting activity changes over time
* Which skills commonly appear together in job descriptions
* How skill demand varies across different job markets

---

## 🎯 Business Objectives

The project answers key questions such as:

1. What are the most demanded skills for Data Analyst roles?
2. Which skills are most relevant for entry-level positions?
3. How does skill demand differ by experience level?
4. Which locations have the highest number of Data Analyst jobs?
5. Which skills frequently appear together?
6. Which companies are hiring Data Analysts?
7. How has job-posting activity changed over time?
8. How many vacancies have structured skill mappings?

---

## 🛠️ Technologies Used

| Technology              | Purpose                                 |
| ----------------------- | --------------------------------------- |
| 🐍 Python               | Data cleaning and preprocessing         |
| 🗄️ MySQL               | Data storage and SQL analysis           |
| 📊 SQL                  | Business analysis and KPI generation    |
| 📈 Power BI             | Interactive dashboard and visualization |
| 🧮 Pandas               | Data manipulation                       |
| 🔢 NumPy                | Data processing                         |
| 📉 Matplotlib / Seaborn | Exploratory visualization               |
| 🔧 Git & GitHub         | Version control and project sharing     |

---

## 📂 Dataset

The project uses the **Data Analyst Skills Evolution (2022–2026)** dataset from Kaggle.

The dataset contains three main tables:

### 1. `vacancies`

Contains job-posting information such as:

* Job ID
* Job title
* Company
* Job description
* Experience requirements
* Location
* Experience level
* Published date

### 2. `skills`

Contains the available skills associated with job postings.

### 3. `vacancy_skills`

A bridge table connecting vacancies with their associated skills.

---

## 🧹 Data Cleaning & Preparation

Python was used to prepare the raw dataset before loading it into MySQL.

Major preprocessing steps included:

* Handling missing values
* Converting date and datetime fields
* Creating year and month fields
* Standardizing location values
* Standardizing experience-level values
* Removing duplicate records
* Checking duplicate IDs
* Standardizing skill names
* Mapping different names of the same skill

### Example of Skill Standardization

Different names referring to the same skill were standardized:


Microsoft Excel → Excel
MS Excel → Excel
Microsoft Power BI → Power BI
PowerBI → Power BI
Microsoft PowerBI → Power BI

Skills such as SQL, MySQL, PostgreSQL and SQL Server were kept separate because they represent different technologies.

---

## 🗄️ MySQL Database Design

The cleaned data was loaded into MySQL using three main tables:

```text
vacancies
     │
     │
     ▼
vacancy_skills
     │
     ▼
skills
```

### Main relationships

```text
vacancies.id
      │
      │ 1-to-many
      ▼
vacancy_skills.vacancy_id

skills.id
      │
      │ 1-to-many
      ▼
vacancy_skills.skill_id
```

SQL views were also created for Power BI:

* `jobpulse_vacancy_summary`
* `jobpulse_skill_demand`

---

## 🔍 SQL Analysis

SQL was used to generate business insights including:

* Top 10 demanded skills
* Jobs by experience level
* Top job locations
* Job posting trends
* Top hiring companies
* Skills required for entry-level roles
* Skill demand by location
* Skill demand by experience level
* Top skill combinations
* Year-wise skill demand
* Year-over-year skill demand changes
* Company hiring by experience level
* Skill mapping coverage

---

## 📊 Power BI Dashboard

The Power BI dashboard contains multiple analytical sections.

### Page 1 — Job Market Overview

Key metrics and visuals include:

* Total Jobs
* Companies Hiring
* Entry-Level Jobs
* Skills Mapped
* Jobs by Experience Level
* Top 10 Job Locations
* Job Posting Trend
* Skill Mapping Coverage

### Page 2 — Skill Intelligence

The page focuses on skill-market analysis:

* Top 10 Most Demanded Skills
* Skill Demand by Experience Level
* Skill Demand by Location
* Experience Level filter
* Location filter
* Interactive skill analysis

---

## 📈 Key Findings

Based on the standardized skill mapping, the most frequently demanded skills include:

| Rank | Skill              | Job Postings |
| ---: | ------------------ | -----------: |
|    1 | SQL                |        1,298 |
|    2 | Excel              |          825 |
|    3 | Python             |          760 |
|    4 | Tableau            |          685 |
|    5 | Power BI           |          607 |
|    6 | R                  |          395 |
|    7 | Data Visualization |          248 |
|    8 | Data Analysis      |          207 |
|    9 | SAS                |          169 |
|   10 | Data Modeling      |          166 |

These results highlight the importance of **SQL, Excel, Python, Tableau, and Power BI** in the analyzed Data Analyst job market.

---

## 📷 Dashboard Preview

### Job Market Overview

![Job Market Overview]("C:\Users\Admin\jobpulse\photo_!.png")


---

## 🚀 Project Workflow


Raw Kaggle Dataset
        ↓
Python Data Cleaning
        ↓
Skill Standardization
        ↓
MySQL Database
        ↓
SQL Analysis
        ↓
SQL Views
        ↓
Power BI Data Model
        ↓
Interactive Dashboard
        ↓
Business Insights


---

## 💡 What I Learned

Through this project, I strengthened my practical understanding of:

* Real-world data cleaning
* Missing-value handling
* Data validation
* Data normalization
* Skill standardization
* Relational database design
* SQL joins and aggregations
* CTEs and window functions
* Business KPI development
* Power BI data modeling
* Dashboard design
* Interactive data visualization
* Turning raw data into business insights

---

## 👩‍💻 Author

**Shreya Dhumal**

Final Year Computer Engineering Student | Aspiring Data Analyst

### Skills

Python` `SQL` `MySQL` `Excel` `Power BI` `Data Visualization` `Data Analysis

---

## ⭐ Project Highlights

* End-to-end Data Analytics project
* 2,154 job vacancies analyzed
* 1,873 vacancies with structured skill mappings
* 13,032 vacancy-skill relationships
* Skill-name standardization performed before analysis
* SQL-based analytical queries and views
* Interactive Power BI dashboard
* Recruiter-focused job-market insights

---

## 📌 Future Improvements

Possible future enhancements include:

* Adding salary information where reliable salary data is available
* Extracting additional skills directly from job descriptions
* Building an automated skill-gap analyzer
* Adding job-role recommendations
* Adding more advanced time-series analysis
* Automating the data pipeline for regularly updated job-market data
