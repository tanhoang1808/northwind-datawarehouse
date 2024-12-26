### This project is built based on the Northwind dataset and represents Kimball's approach to creating a replica of the Northwind Data Warehouse.

![Input Schema](assets/architecture_v1.png)

The purpose of this project is to demonstrate my knowledge and capability in transforming data using SQL and dbt.

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

![Fact-Dimension Model](assets/northwind_physical.png)
