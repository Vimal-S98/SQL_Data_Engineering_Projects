SELECT
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestamptz
FROM job_postings_fact
LIMIT 10;



-- EXTRACT
SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(*) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY 
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY job_posted_year, job_posted_month;



-- DATE_TRUNC
SELECT
    job_posted_date,
    DATE_TRUNC('MONTH', job_posted_date) AS trunc_month
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;


-- Combining EXTRACT and DATE_TRUNC
SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Engineer'
    AND
    EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY 
    DATE_TRUNC('month', job_posted_date)
ORDER BY job_posted_month;



-- AT TIME ZONE
SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'GMT';


-- Timestamp in data without timezone
SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
WHERE job_location LIKE 'New York, NY';



SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'IST') AS job_posted_hour,
    COUNT(job_id)
FROM job_postings_fact
WHERE job_location LIKE 'New York, NY'
GROUP BY EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'IST')
ORDER BY job_posted_hour;

























