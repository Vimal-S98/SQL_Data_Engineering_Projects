-- SUBQUERY

-- Scenario 1 - Subquery in SELECT
-- Show each job's salary next to the overall market median:
SELECT 
    job_title_short,
    salary_year_avg,
    (SELECT MEDIAN(salary_year_avg) 
    FROM job_postings_fact) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;



-- Scenario 2 - Subquery in FROM
-- Stage only jobs that are remote before aggregating to determine the remote median salary per job:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = True
    ) AS median_market_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = True
)
GROUP BY job_title_short
LIMIT 10;



-- Scenario 3 - Subquery in HAVING
-- Keep only job titles whose median salary is above the overall median:

SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = True
    ) AS remote_median_market_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = True
)
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = True
)
LIMIT 10;



-- CTEs

-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.
WITH wfh AS (
    SELECT
        job_title_short,
        MEDIAN(salary_year_avg) AS wfh_median
    FROM job_postings_fact
    WHERE job_work_from_home = True AND job_country = 'United States'
    GROUP BY job_title_short
), no_wfh AS (
    SELECT
        job_title_short,
        MEDIAN(salary_year_avg) AS no_wfh_median
    FROM job_postings_fact
    WHERE job_work_from_home = False AND job_country = 'United States'
    GROUP BY job_title_short
)
SELECT
    w.job_title_short,
    w.wfh_median,
    nw.no_wfh_median,
    w.wfh_median - nw.no_wfh_median AS difference
FROM wfh as w
JOIN no_wfh as nw
    ON w.job_title_short = nw.job_title_short;
--------

-- Other Method using CTE
WITH median_salary_cte AS (
    SELECT
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY job_title_short, job_work_from_home
)
SELECT
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM median_salary_cte AS r
JOIN median_salary_cte AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC
;




-- EXISTS and NOT EXISTS


-- Idenify job postings that have no associated skills before loading them into a data mart
SELECT
    job_id,
    job_title_short,
FROM job_postings_fact AS jpf
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    WHERE sjd.job_id = jpf.job_id
)
ORDER BY job_id;



SELECT
    *
FROM RANGE(3) AS src(key);

SELECT
    *
FROM RANGE(2) AS tgt(key);



SELECT
    *
FROM range(3) AS src(key)
WHERE EXISTS (
    SELECT 1
    FROM RANGE(2) AS tgt(key)
    WHERE src.key = tgt.key
);


SELECT
    *
FROM range(3) AS src(key)
WHERE NOT EXISTS (
    SELECT 1
    FROM RANGE(2) AS tgt(key)
    WHERE src.key = tgt.key
);






















