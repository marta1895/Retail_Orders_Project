# Project Overview: Retail Orders Data Analysis
## Dataset Description
The dataset comprises global mart sales data for the years 2022 and 2023, categorized into three main categories: Furniture, Office Supplies, and Technology. Each main category is further divided into detailed sub-categories.
#### 🔗 Kaggle Dataset Link: https://www.kaggle.com/datasets/ankitbansal06/retail-orders/

## 🎯 Project Goals
1. Import Kaggle API into Jupyter Notebook using Python
2. Perform Data Cleaning and Preparation using Pandas
3. Load the Data into SQL Server using the "Replace" Option
4. Load the Data into SQL Server using the "Append" Option
5. Analyze Data using PostgreSQL
6. Visualize summary data using the Tableau platform

## 📋 Repository Structure
```text
Retail_Orders_Project/
├── README.md               # Project overview, steps, and insights
├── data/
│ └── orders.csv            # Raw dataset file
├── notebooks/
│ └── sales_analysis.ipynb  # Data cleaning & preparation
├── sql/
│ └── sales_analysis.sql    # SQL analysis queries
└── tableau/
└── Sales_analysis.twbx     # Tableau dashboard
```

## 🔍 Key Business Questions:
- "Top 10 Revenue-Generating Products"
- "Top 3 Sub-Categories by Total Quantity Sold per Region"
- "Monthly Sales Comparison (2022 vs 2023) with Growth %"
- "Month with the Highest Sales for Each Category"
- "Sub-Category with the Highest Sales Growth in 2023 Compared to 2022"
  
# Steps and Implementation

## ⚙️ 1. Import Kaggle API into Jupyter Notebook
   
#### • First, I obtained Kaggle API Credentials by downloading a file named kaggle.json to my computer, which contains my username and an API key

#### • Installation of the opendatasets library in Jupiter Notebook
<img width="1600" height="891" alt="image" src="https://github.com/user-attachments/assets/34267b41-6617-47e8-81c3-3c8671359d88" />


*The opendatasets library allows direct and automated downloading of Kaggle datasets into Jupyter Notebook using the Kaggle API, making the data import process faster and more efficient.

#### • Installation of the pandas library in Jupiter Notebook
<img width="1600" height="207" alt="image" src="https://github.com/user-attachments/assets/f04f4963-5be1-4ec6-addc-bc2de172714c" />

#### • Importing the opendatasets and pandas libraries, and downloading the Kaggle dataset into Jupiter Notebook
<img width="1600" height="419" alt="image" src="https://github.com/user-attachments/assets/16f70606-0ad9-4ba4-ab16-79949107965f" />

*During the import process, I added the Kaggle API credentials obtained in the first step. Then, the dataset was successfully downloaded from Kaggle using the Kaggle API.

## 🧹 2. Perform Data Cleaning and Preparation using Pandas
   
#### • Reading the data from the .csv file of the downloaded dataset by using pd.read_csv() function
<img width="1600" height="449" alt="image" src="https://github.com/user-attachments/assets/bee90c19-d687-4808-a1b2-c94f004d16f0" />

*pd.read_csv() function is a core command in the pandas library used to read a comma-separated values (CSV) file into a pandas DataFrame. After I uploaded the .csv file and confirmed a successful upload, we can start with data cleaning

#### • Handling null values
<img width="1600" height="472" alt="image" src="https://github.com/user-attachments/assets/4941bd3c-6054-43c4-99af-76235d303900" />

#### • Identifying missing values by column
<img width="1600" height="568" alt="image" src="https://github.com/user-attachments/assets/e645f628-c082-4550-93c8-49e17166092d" />

We can see that the Ship Mode column contains 6 missing values, while all other columns have no missing entries.

#### • Cleaning and standardizing column names
<img width="1600" height="568" alt="image" src="https://github.com/user-attachments/assets/0064a903-d570-4a6c-b82e-8324a7ae01d1" />

#### • Fixing incorrect data types
First, we check the data types of each column using df.info()
<img width="1600" height="604" alt="image" src="https://github.com/user-attachments/assets/f8c26243-341b-492a-b902-47ff5e36b6ba" />

From the output, we can see that only the order_date column has an incorrect data type. It is stored as an object instead of a datetime data type. The rest of the numeric columns (cost_price, list_price, quantity, and discount_percent) were reviewed using df.info(), all columns were already stored as numeric (int64) data types, so no additional conversion was required.

The order_date column is converted from a string (object) data type to a datetime data type using pd.to_datetime()
<img width="1600" height="70" alt="image" src="https://github.com/user-attachments/assets/e9be3cf7-d6bf-46a2-99fb-8764acf2b31e" />

#### • Identifying whether the order_id column is considered as a primary key
<img width="1600" height="304" alt="image" src="https://github.com/user-attachments/assets/ff8d6c4d-e6ae-4525-bce6-12e63cc0f89d" />

The order_id column was reviewed and found to contain unique, non-null values across all rows. Therefore, it can be treated as a primary key for the dataset.

#### • Deriving new columns: "discount", "sale_price" and "profit"
Three additional columns were derived to support further analysis of pricing and profitability:
- discount – monetary discount applied to the list price
- sale_price – final price after discount
- profit – difference between sale price and cost price

<img width="1600" height="669" alt="image" src="https://github.com/user-attachments/assets/20d1cf14-2160-46f4-a412-b8ee5a3b9088" />

#### • Dropping original pricing columns
After deriving the discount, sale_price, and profit columns, the original pricing columns (cost_price, list_price, and discount_percent) were removed, as all further analysis can be performed using the newly derived fields.
<img width="1600" height="622" alt="image" src="https://github.com/user-attachments/assets/a47fd29f-63d6-4361-930d-9d42fb711b42" />

## 🛠️ 3. Load the Data into SQL Server using the "Replace" Option
   
#### • Installation of the SQLAlchemy library
<img width="1600" height="116" alt="image" src="https://github.com/user-attachments/assets/e9a04f78-4b41-4ca0-b9dd-9d6bcf2c199d" />

#### • Importing SQLAlchemy library, setting up the database connection details, creating a connection string for PostgreSQL, and establishing a connection to the PostgreSQL database using SQLAlchemy
<img width="1600" height="424" alt="image" src="https://github.com/user-attachments/assets/151c96d1-9c05-4dab-bc88-19a85cca16d2" />

#### • Load the data into SQL Server using the Replace function
<img width="1600" height="129" alt="image" src="https://github.com/user-attachments/assets/1f8dc02d-301c-4fe5-b237-d44d39eeaeed" />

#### • Checking the SQL Server to see if the data is loaded
<img width="1232" height="923" alt="image" src="https://github.com/user-attachments/assets/8632653f-4369-4747-91c4-e2d3f6c11de2" />

*In the screenshot above, you can see that the data has been successfully loaded into SQL Server. However, the data type for each column is not quite appropriate and is too large, such as bigint, text, and an undefined primary key, as well as incorrect date data types. This happened because I was using the "Replace" option and pandas created a table with the highest possible data types.

## 🛠️ 4. Load the Data into SQL Server using the "Append" Option

#### • Fixing the improper data type issue by using the "Append" option instead of the "Replace" option

First, I dropped the table.
<img width="1218" height="846" alt="image" src="https://github.com/user-attachments/assets/020b3f5a-347f-4c88-8736-12ed6a0a116d" />

Then, I created the empty table with the respective columns defined with the appropriate data type sizes.
<img width="1600" height="915" alt="image" src="https://github.com/user-attachments/assets/364d274e-01bc-490a-b678-a3eb4504b615" />

Next, getting back to the Jupyter Notebook, I implemented the "Append" option instead of the "Replace" option.
<img width="1600" height="534" alt="image" src="https://github.com/user-attachments/assets/6392e231-682f-478e-9147-7163e6290660" />

#### • Checking if the data is loaded with the "Append" option
In the screenshot below, I highlighted in yellow the new data type sizes that are much more efficient.
![image](https://github.com/marta1895/Retail_Orders_Project/assets/141928743/4d83543b-9521-497b-b181-4ff60b979b3b)

By following these steps, you should have successfully loaded your data into SQL Server using the "Append" option, ensuring that the data types are appropriate and efficient.

## 📊 5. Analyze Data using PostgreSQL

In this section, I identified the key business questions.

#### • Find Top 10 Revenue-Generating Products 
<img width="1600" height="925" alt="image" src="https://github.com/user-attachments/assets/2de1ae2a-4ff6-4c89-9ea0-69ad0339d2e2" />

#### • Top 3 Sub-Categories by Total Quantity Sold per Region
<img width="1600" height="1009" alt="image" src="https://github.com/user-attachments/assets/4da20eb9-ce31-46a5-bebe-523ec65e0431" />
<img width="1600" height="671" alt="image" src="https://github.com/user-attachments/assets/cf4d3aed-5341-42a9-8efc-249a7fe80964" />

#### • Monthly Sales Comparison (2022 vs 2023) with Growth %
<img width="1600" height="1063" alt="image" src="https://github.com/user-attachments/assets/fa2feb8c-0155-4536-885e-105e2f3b7423" />
<img width="994" height="832" alt="image" src="https://github.com/user-attachments/assets/cf485d56-287f-48a1-abf0-caf6b4a1eee9" />

#### • Find the Month with the Highest Sales for Each Category
<img width="1600" height="1383" alt="image" src="https://github.com/user-attachments/assets/6d886487-e47b-4696-b042-49c8f90457f0" />

#### • Find the Sub-Category with the Highest Sales Growth in 2023 Compared to 2022
<img width="1600" height="1202" alt="image" src="https://github.com/user-attachments/assets/ece1fa1d-5900-4b4d-b6a6-51983d10f5ee" />

Additionally, I decided to include several additional metrics to provide a more complete picture in the visualization:

#### • Find the Total number of Orders Distributed for Years: 2022 vs 2023
<img width="1600" height="702" alt="image" src="https://github.com/user-attachments/assets/c1dce452-251c-4d95-8e2d-2c4eb78591ee" />

#### • Find the Total Sales by State (U.S.)
<img width="1600" height="1095" alt="image" src="https://github.com/user-attachments/assets/4b6e5da3-e41c-4126-8bad-cc3f83b3e670" />

#### • Find the Top-Performing Sub-Categories with Total Sales Exceeding $800K.
<img width="1600" height="960" alt="image" src="https://github.com/user-attachments/assets/687ba05c-c1b1-4781-8e41-9a7a61aeafc5" />
<img width="1600" height="641" alt="image" src="https://github.com/user-attachments/assets/c9502662-d847-4551-988c-fec698a4c356" />

#### • Find the Total Revenue Distribution: 2022 vs 2023
<img width="1600" height="668" alt="image" src="https://github.com/user-attachments/assets/77a118c0-011f-42ac-bfa5-35dd8d896e88" />

#### • Find the Profit Growth (YoY): 2023 compared to 2022
<img width="1600" height="808" alt="image" src="https://github.com/user-attachments/assets/2b45a271-59d5-4b4d-a42a-3f9b0695c869" />

## 📈 6. Visualize summary data using the Tableau platform

<img width="1600" height="1073" alt="image" src="https://github.com/user-attachments/assets/5cf1a07e-cd74-4885-8388-be3bd68d8a81" />

🔗 Link to Tableau Dashboard: https://public.tableau.com/app/profile/marta.narozhnyak/viz/shared/ZGQTXF3CW




