-- Partition By Find hourly salary
SELECT
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (PARTITION BY job_title_short)
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 10;



-- Finding running avg hourly avg salary for each job title
SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(PARTITION BY job_title_short ORDER BY job_posted_date) AS running_avg_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
    AND
      job_title_short = 'Data Engineer'
ORDER BY job_title_short, job_posted_date
LIMIT 10;




-- Ranking Salary in each job
SELECT
    job_title_short,
    salary_hour_avg,
    RANK() OVER(PARTITION BY job_title_short ORDER BY salary_hour_avg DESC) AS rank_hourly_salary
FROM job_postings_fact
ORDER BY salary_hour_avg DESC, job_title_short
LIMIT 10;



-- USing row_number to generate id's
SELECT
    *,
    ROW_NUMBER() OVER(ORDER BY job_posted_date) AS new_id
FROM job_postings_fact
LIMIT 20;


-- USE ROW NUMBER TO RANK salary_hour_avg
SELECT
    job_title_short,
    salary_hour_avg,
    ROW_NUMBER() OVER(ORDER BY salary_hour_avg) AS rank_hourly_salary
FROM job_postings_fact
ORDER BY rank_hourly_salary
LIMIT 20;


-- USING LAG
SELECT
    job_title_short,
    company_id,
    salary_year_avg,
    LAG(salary_year_avg) OVER(PARTITION BY company_id ORDER BY job_posted_date) AS previous_salary,
    salary_year_avg - LAG(salary_year_avg) OVER(PARTITION BY company_id ORDER BY job_posted_date) AS difference_previous
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id, job_posted_date
LIMIT 20;

















