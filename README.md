# Description

This project is built based on the Northwind dataset and represents Kimball's approach to creating a replica of the Northwind Data Warehouse.
![Input Schema](assets/architecture_v1.png)

## Technique

- SQL
- Lib : dbt-ultils,dbt-expectations
- Install virtual environment

  ```bash
     pip3 -m venv northwind_project_env
     pip3 install dbt-core dbt-snowflake
  ```

  - Database : Snowflake

    - Init warehouse , database, user and role for transformation

    ```bash
      USE ROLE ACCOUNTADMIN
      CREATE ROLE IF NOT EXISTS TRANSFORM
      GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN
      CREATE WAREHOUSE IF NOT EXISTS NORTHWIND_WH;


      CREATE USER IF NOT EXISTS ethan
      PASSWORD = '123456'
      LOGIN_NAME = 'ethan'
      DEFAULT_WAREHOUSE = 'NORTHWIND_WH'
      DEFAULT_ROLE = TRANSFORM
      DEFAULT_NAMESPACE = 'NORTHWIND'

      GRANT ROLE TRANSFORM TO USER ethan
      CREATE DATABASE IF NOT EXISTS NORTHWIND
      DROP SCHEMA IF EXISTS NORTHWIND.RAW
      CREATE SCHEMA IF NOT EXISTS NORTHWIND.RAW


      GRANT ALL ON WAREHOUSE NORTHWIND_WH TO ROLE TRANSFORM
      GRANT ALL ON DATABASE NORTHWIND to ROLE TRANSFORM
      GRANT ALL ON ALL SCHEMAS IN DATABASE NORTHWIND to ROLE TRANSFORM
      GRANT ALL ON FUTURE SCHEMAS IN DATABASE NORTHWIND to ROLE TRANSFORM
      GRANT ALL ON ALL TABLES IN SCHEMA NORTHWIND.RAW to ROLE TRANSFORM
      GRANT ALL ON FUTURE TABLES IN SCHEMA NORTHWIND.RAW to ROLE TRANSFORM

    ```

  ```

  ```

### Key Design Aspects of the Data Warehouse:

1. **Sales Overview**

   - Provides overall sales reports to better understand customer behavior: what is being sold, what sells the most, where, and what sells the least.
   - The goal is to gain a general overview of business performance.

2. **Product Inventory**

   - Helps understand current inventory levels and improve stock management.
   - Identifies suppliers, tracks purchasing trends, and analyzes stock data.
   - This enables better stock control and facilitates negotiations with suppliers for better deals.

3. **Customer Reporting**
   - Allows customers to track their purchase orders, including how much they are buying and when.
   - Empowers customers to make data-driven decisions and integrate their sales data for better insights.

### Fact and Dimension Representation:

### The Fact-Dimension model can be represented in the physical layer as shown below:

### Packages used in in project:

- dbt-utils
- dbt-expectations

![Fact-Dimension Model](assets/northwind_physical.png)
