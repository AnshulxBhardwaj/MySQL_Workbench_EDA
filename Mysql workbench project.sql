
-- First look at data
SELECT * from layoffs;

-- Tasks:
-- Remove Duplicates
-- Standardize the Data 
-- Null Values or blank values
-- Remove any unused Columns

-- Creating a staging table to keep main table untouched 
CREATE TABLE layoff_staging Like Layoffs;

Alter TABLE layoff_staging
RENAME TO layoffs_staging;

-- checking for empty table 
SELECT * from layoffs_staging;

-- populating the table
INSERT layoffs_staging 
SELECT * FROM layoffs;

-- checking for populated table 
SELECT * FROM layoffs_staging;

-- Removing duplicated rows 

SELECT *, 
ROW_NUMBER()  OVER(
PARTITION BY company, industry, percentage_laid_off, total_laid_off, 'date') AS rownum 
FROM layoffs_staging;


WITH dupl_cte AS 
(
SELECT *, 
ROW_NUMBER()  OVER(
PARTITION BY company, industry, total_laid_off, 'date') AS rownum 
FROM layoffs_staging)

SELECT * FROM dupl_cte
WHERE rownum > 1;

SELECT * FROM layoffs_staging
WHERE company = 'Oda';

SELECT *, 
ROW_NUMBER()  OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date',stage, country, funds_raised_millions) AS rownum 
FROM layoffs_staging;


WITH dupl_cte AS 
(
SELECT *, 
ROW_NUMBER()  OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions) AS rownum 
FROM layoffs_staging)

SELECT * FROM dupl_cte
WHERE rownum > 1;

select * from layoffs_staging
where company='Spotify';

-- Create a staging table with additional row_num column
CREATE TABLE `layoffs_world_db`.`layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT,
    `row_num` INT
);

-- Insert data into the staging table with row numbers
INSERT INTO `layoffs_world_db`.`layoffs_staging2`
(`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`, `row_num`)
SELECT `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
    ) AS row_num
FROM `layoffs_world_db`.`layoffs_staging`;

-- Delete duplicate rows based on row_num
DELETE 
FROM `layoffs_world_db`.`layoffs_staging2`
WHERE row_num > 1;

SELECT * 
FROM layoffs_world_db.layoffs_staging2;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
order BY 1;

SELECT  *
FROM layoffs_staging2
WHERE industry like 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry like 'Crypto%';

SELECT  *
FROM layoffs_staging2
WHERE industry like 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;


-- quick google search and we give industry 'Other' tag for Company Bally Interactive

UPDATE layoffs_staging2 
SET industry = 'Other'
where company Like 'Bally%';

-- Cleaning data for Country column
SELECT *
FROM layoffs_world_db.layoffs_staging2;

SELECT DISTINCT country
FROM layoffs_world_db.layoffs_staging2
ORDER BY country;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- now if we run this again it is fixed

SELECT DISTINCT country
FROM layoffs_world_db.layoffs_staging2
ORDER BY country;

-- Taking a look at date columns
SELECT date
FROM layoffs_world_db.layoffs_staging2;

-- we can use str_to_date to update this field

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- convert the data type to date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- checking for use less rows

SELECT *
FROM layoffs_world_db.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Deleting useless data we can't really use
DELETE FROM layoffs_world_db.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_world_db.layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

