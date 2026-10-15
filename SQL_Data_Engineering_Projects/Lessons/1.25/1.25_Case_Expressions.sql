----------------------------- CASE EXPRESSIONS ----------------------------------


-- Categorising:
/* Bucket Salaries
< 25 = 'Low'
25 - 50 = 'Medium'
> 50 = 'High'
*/

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;




-- Handling Missing Data (Nulls)
-- Filter NULL salary values

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
LIMIT 10;





-- Categorizing Categorical Values
-- Classify the `job_title` column values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'

SELECT
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Business%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Engineer'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_category,
    job_title_short
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;  




-- Conditional Aggregation
-- Calculate Median Salary for different buckets
    -- <$100K
    -- >$100K

SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MEDIAN(
        CASE
            WHEN salary_year_avg < 100_000 THEN salary_year_avg
        END 
    ) AS median_low_salary,
    MEDIAN(
        CASE
            WHEN salary_year_avg > 100_000 THEN salary_year_avg
        END
    ) AS median_high_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
LIMIT 10;




-- Compute a standardized_salary using yearly salary and adjusted hourly salary (eg. 2080 working hours/year)
-- Categorize salaries into tiers of:
    -- < 75K 'Low'
    -- 75 - 150K 'Medium'
    -- >= 150K 'High'


WITH salaries AS (
    SELECT
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        END AS standardized_salary
    FROM
        job_postings_fact
    WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
    LIMIT 10
)
SELECT
    *,
    CASE
        WHEN standardized_salary < 75_000 THEN 'Low'
        WHEN standardized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM salaries
LIMIT 10;





















