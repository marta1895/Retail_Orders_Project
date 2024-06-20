# Project Overview: Retail Orders Data Analysis
## Dataset Description
The dataset comprises global mart sales data for the years 2022 and 2023, categorized into three main categories: Furniture, Office Supplies, and Technology. Each main category is further divided into detailed sub-categories.

## Project Goals
- Import Kaggle API into Jupyter Notebook using Python
- Perform Data Cleaning and Preparation using Pandas
- Load the Data into SQL Server using the "Replace" Option
- Load the Data into SQL Server using the "Append" Option
- Analyze Data using PostgreSQL
- Viziulaze summary data using Tableu platrform
  
## Steps and Implementation

### 1. Import Kaggle API into Jupyter Notebook
   
#### - Instalation of Kaggle
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/6648685d-e526-4bcf-be9b-2f71bbab61ac)

#### - Downloading dataset using Kaggle API
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/2400cd12-7fcf-4227-a30a-97d5dbbfb06b)

#### - Extracting the file from the zip file
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/d8c4ab84-7836-4965-a824-293cddb2f487)

### 2. Perform Data Cleaning and Preparation using Pandas
   
#### - Reading the data from the file and handle null values
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/f08cab01-c388-4122-ad09-d0762558fb4a)

#### - Renaming of columns names, making them lower case and replacing space with underscore 
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/9aaad536-3ad8-4140-b375-5f0183832b42)

#### - Deriving new columns: "discount", "sale_price" and "profit"
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/a01667f5-17a2-4858-bd31-d9e5b95036f2)

#### - Converting column "order_date" from object data type to datatime
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/b8b071a8-51d2-4e69-aca8-cbf4abf157d6)

#### - Dropping the columns: "cost_price", "list_price" and "discount_percent"
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/573a721a-00b4-4b2a-84d2-c97e93766d21)

### 3. Load the Data into SQL Server using the "Replace" Option
   
#### - Importing SQLAlchemy library, setting up the database connection details, creating a connection string for PostgreSQL, and establishing a connection to the PostgreSQL database using SQLAlchemy
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/cdabc90f-f7eb-406b-878d-6c74fd556762)

#### - Checking the SQL Server if the data is loaded
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/f5356e50-826b-4565-8a00-bf2b3f03972c)
In the screenshot above, you can see that the data has been successfully loaded into SQL Server. However, the data type for each column is not quite appropriate and is too large, such as bigint, text, not defined as Primary Key, and date data type. This happened because I was using the "Replace" option and pandas created a table with the highest possible data types.

### 4. Load the Data into SQL Server using the "Append" Option.

#### - Fixing the improper data type issue by using the "Append" option instead of the "Replace" option
First, I dropped the table.

![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/be02194c-9476-4b82-9c72-149280e0a2ba)

Then, I created the empty table with the respective columns defined with the appropriate data type sizes.![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/b5674935-bde1-4389-8f0c-4be72db003a3)

Next, I implemented the "Append" option instead of the "Replace" option.
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/e10ccc7a-7643-464d-a390-6af62eabb9e7)

#### - Checking if the data is loaded with the "Append" option
In the screenshot below, I highlighted in yellow the new data type sizes that are much more efficient.
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/4d83543b-9521-497b-b181-4ff60b979b3b)

By following these steps, you should have successfully loaded your data into SQL Server using the "Append" option, ensuring that the data types are appropriate and efficient.
### 5. Analyze Data using PostgreSQL

#### - Find Top 10 hoghest revue generating products
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/e272b08c-ddc4-463d-a12b-f0b563d62f5d)

#### - Find Top 5 highest selling products in each region
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/6a227b35-9c3a-4e32-87b4-f2bbec792bbb)

#### - Find month over month growth comparison for 2022 and 2023 sales eg : Jan 2022 VS Jan 2023
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/e1f43892-2147-4948-86b0-fca37fd5e307)

#### - For each category which month had highest sales
