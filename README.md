# Project Overview: Retail Orders Data Analysis
## Dataset Description
The dataset comprises global mart sales data for the years 2022 and 2023, categorized into three main categories: Furniture, Office Supplies, and Technology. Each main category is further divided into detailed sub-categories.

## Project Goals
- Import Kaggle API into Jupyter Notebook using Python
- Perform Data Cleaning and Preparation using Pandas
- Load the Data into SQL Server using the "Replace" Option
- Analyze Data using PostgreSQL
- Viziulaze summery data using Tableu platrform
  
## Steps and Implementation
1. Import Kaggle API into Jupyter Notebook
#instalation of kaggle
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/6648685d-e526-4bcf-be9b-2f71bbab61ac)

#download dataset using kaggle api
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/2400cd12-7fcf-4227-a30a-97d5dbbfb06b)

#extract file from zip file
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/d8c4ab84-7836-4965-a824-293cddb2f487)

2. Perform Data Cleaning and Preparation using Pandas
#read data from the file and handle null values
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/f08cab01-c388-4122-ad09-d0762558fb4a)

#renaming of columns names, makeing them lower case and replacing space with underscore 
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/9aaad536-3ad8-4140-b375-5f0183832b42)

#derive new columns: discount, sale_price and profit
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/a01667f5-17a2-4858-bd31-d9e5b95036f2)

#convert order_date from object data type to datatime
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/b8b071a8-51d2-4e69-aca8-cbf4abf157d6)

#dropping the columns: cost_price, list_price and discount_percent
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/573a721a-00b4-4b2a-84d2-c97e93766d21)

3. Load the Data into SQL Server using the "Replace" Option
#importing SQLAlchemy library, setting up the database connection details, creating a connection string for PostgreSQL, and establishing a connection to the PostgreSQL database using SQLAlchemy
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/cdabc90f-f7eb-406b-878d-6c74fd556762)



