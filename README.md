# MySQL Workbench Project: Exploratory Data Analysis (EDA)

## Purpose
My project focused on conducting exploratory data analysis (EDA) on a dataset containing information about layoffs.
The primary goal was to uncover trends, patterns, and characteristics of layoffs across different dimensions such as companies, industries, locations, and time periods.

## Database Structure
The database structure revolved around a table named "layoffs_staging2". 
It housed columns like company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, and funds_raised_millions, each storing vital details about layoffs and related information.

## Functionality
Data Cleaning: I started with data cleaning tasks, including removing duplicates, standardizing data, handling null values, and trimming unused columns to ensure the dataset was clean and ready for analysis.

Exploratory Data Analysis: Delving into exploratory data analysis, I conducted various analyses such as identifying companies with significant layoffs, examining layoffs by location, year, industry, and stage of the company, among others.

Data Transformation: As part of data transformation, I converted the "date" column from text to date format using the STR_TO_DATE function. Additionally, I updated values in the "industry" and "country" columns to ensure consistency and accuracy across the dataset.

Data Visualization: While not explicitly stated in the SQL code, I recognized the importance of data visualization in enhancing the presentation of my findings. Charts or graphs could provide a clearer understanding of the insights derived from the exploratory analysis.

## Challenges Faced
Throughout the project, I encountered challenges, particularly in data cleaning. 
Addressing duplicate rows, standardizing values, handling null values, and ensuring data consistency across columns like "industry" and "country" required careful attention and effort.

## Tools Used
For this project, my primary tool was MySQL Workbench, though I might have utilized other SQL-based tools or libraries for data analysis and manipulation.

