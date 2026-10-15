-- LENGTH & CHAR Length

SELECT LENGTH('SQL');

SELECT CHAR_LENGTH('SQL');


-- UPPER & LOWER

SELECT UPPER('Sql');

SELECT LOWER('Sql');


-- SUBSTRING

SELECT LEFT('SQL', 2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('VIMAL', 2, 3);



-- CONCAT

SELECT CONCAT('SQL', '-', 'Functions');

SELECT 'SQL' || '-' || 'Functions';


-- TRIM
SELECT '  SQL  ';

SELECT TRIM('  SQL  ');



-- REPLACE
SELECT REPLACE('SQL', 'Q', '_');





-- EXAMPLE

WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean,
        job_title_short
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%business%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_category,
    job_title_short
FROM title_lower
ORDER BY RANDOM()
LIMIT 20; 






-- NULL FUNCTIONS

-- NULLIF
SELECT NULLIF(10, 30);

SELECT NULLIF(40, 40);

-- USE CASE
SELECT
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 10;




-- COALESCE
SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080) AS yearly_avg_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;



-- FINAL COALESCE EXAMPLE
SELECT
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080) AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 75000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 150000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
ORDER BY standardized_salary DESC;







