# 📦 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project**! 🚀

This portfolio project demonstrates a comprehensive data warehousing and analytics solution, from ingesting and transforming raw data to delivering business-ready insights using SQL-based analytics. It follows the Medallion Architecture and best practices in data engineering and analytics.

---

## 📘 Project Overview

This project involves:

1. **Data Architecture**: Designing a modern data warehouse using the Medallion Architecture (*Bronze*, *Silver*, and *Gold* layers).
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the data warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable business insights.

> 🎯 This repository is an excellent resource for professionals and students looking to showcase expertise in:
> - SQL Development
> - Data Architecture
> - Data Engineering
> - ETL Pipeline Development
> - Data Modeling
> - Data Analytics

---

## 📋 Project Requirements

### Building the Data Warehouse (Data Engineering)

**Objective:**  
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

**Specifications:**
- **Data Sources:** Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality:** Cleanse and resolve data quality issues prior to analysis.
- **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope:** Focus on the latest dataset only; historization of data is not required.
- **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

## 📊 SQL-Based Analytics Project Overview

### Focus Areas
This project delivers insights into:
- 🧍 **Customer Behavior**
- 📦 **Product Performance**
- 📈 **Sales Trends**

These insights empower stakeholders to make data-driven business decisions.

---

## 🏗️ Data Architecture (Medallion Architecture)
![datawarehouse](https://github.com/user-attachments/assets/b0bc7dca-32a3-48bd-9730-8c4c659329dd)

### 🔹 Bronze Layer (Raw Data)
- **Source:** ERP & CRM Systems (CSV Files)
- **Database:** SQL Server
- **Object Type:** Tables  
- **Load Method:**
  - Batch Processing
  - Full Load (Truncate & Insert)
- **Transformations:** None (raw data)
- **Model:** None

### 🔸 Silver Layer (Cleaned Data)
- **Object Type:** Tables
- **Process:** `Silver Procedure`
- **Load Method:**
  - Batch Processing
  - Full Load (Truncate & Insert)
- **Transformations:**
  - Data Cleansing
  - Data Stratification
  - Data Normalization
  - Derived Columns
  - Data Enrichment
- **Model:** None

### 🟡 Gold Layer (Business-Ready Data)
- **Object Type:** Views
- **Load Method:** No load (views only)
- **Transformations:**
  - Data Integrations
  - Aggregations
  - Business Logic
- **Data Models:**
  - Star Schema
  - Flat Tables
  - Aggregated Tables

---

## 📥 Consumption Layer

Processed data is consumed by:
- 📊 BI & Reporting Tools (Power BI, Tableau, etc.)
- 🔎 Ad-Hoc SQL Queries
- 🤖 Machine Learning Applications

---

## 🛠️ Technologies Used

- SQL Server
- T-SQL (Stored Procedures, Views)
- CSV Data Files (ERP & CRM)
- Git & GitHub for version control

## 📈 Visual Diagrams

### Data Flow Diagram  
This diagram illustrates the end-to-end data flow starting from source CSV files (ERP & CRM) through the Medallion Architecture layers — Bronze, Silver, and Gold — and finally to the consumption layer for analytics and reporting.

![image](https://github.com/user-attachments/assets/1c43b672-9ae5-476a-8332-1415602b296c)


---

### Integration Model  
The integration model visualizes how the cleaned tables in the Silver layer relate to each other through primary and foreign keys, demonstrating the relationships between dimension and fact tables.

![image](https://github.com/user-attachments/assets/44154ec7-cc9e-4f33-bf80-cf045aefde4a)


---

### Data Mart (Star Schema)  
This star schema diagram shows the fact table at the center surrounded by dimension tables in the Gold layer, representing the optimized schema for analytical queries.

![image](https://github.com/user-attachments/assets/ee786b31-28a3-46ce-bc96-655332a1481b)


##🙋 About Me
I am Rishabh, an aspiring Data Analyst. Through this project, I have learned how data flows and works behind the scenes before it is analyzed. This experience has helped me understand the importance of data engineering, cleansing, and modeling in preparing data for meaningful analysis.

Connect with me on LinkedIn: https://www.linkedin.com/in/heyrishabh2003/

