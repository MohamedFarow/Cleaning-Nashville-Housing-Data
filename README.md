# Cleaning-Nashville-Housing-Data
Here is a general description of the SQL code provided:

The code performs various data cleaning and standardization operations on a Nashville Housing Data table. It begins by converting the SaleDate column to a proper date format using the CONVERT function. This makes it easier to work with and analyze the dates. 

Next, it handles null values in the PropertyAddress column by joining the table to itself to populate missing values. The ISNULL function is used to populate nulls from the join. This ensures there are no missing property addresses.

After that, the PropertyAddress column is split into separate Address and City columns using string functions like SUBSTRING and CHARINDEX. This splits the column for better analysis. Similarly, the OwnerAddress column is split into Address, City and State columns using PARSENAME and REPLACE. 

The code also standardizes the SoldAsVacant column, which has values like 'Y' and 'N', into 'Yes' and 'No' using a CASE statement. This makes the data more intuitive and consistent.

Overall, the SQL code focuses on data cleaning tasks like handling nulls, splitting columns and standardizing formats. It takes raw housing data and transforms it into a more analysis-ready state. The cleaned data could then be used for further analytics, reporting and visualizations to gain insights.
