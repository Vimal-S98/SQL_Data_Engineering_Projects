-- Example - Find top 10 companies for postings that have > 3000 postings
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS postings_count
FROM job_postings_fact AS jpf
JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(job_id) > 3000
ORDER BY postings_count DESC
LIMIT 10;


-- EXPLAIN

EXPLAIN
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS postings_count
FROM job_postings_fact AS jpf
JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(job_id) > 3000
ORDER BY postings_count DESC
LIMIT 10;


-- EXPLAIN ANALYZE

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS postings_count
FROM job_postings_fact AS jpf
JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(job_id) > 3000
ORDER BY postings_count DESC
LIMIT 10;






















