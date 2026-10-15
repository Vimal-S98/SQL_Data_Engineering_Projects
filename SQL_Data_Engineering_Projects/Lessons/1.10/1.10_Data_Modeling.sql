SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
FROM
    job_postings_fact
LIMIT 10;

-- Information schema of our data_jobs tables
SELECT 
    *
FROM information_schema.tables
WHERE table_catalog = 'data_jobs';

-- Information schema of our columns in data_jobs tables
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';


-- Information schema of table_constraints
SELECT *
FROM information_schema.table_constraints
WHERE table_catalog = 'data_jobs';


-- Information schema of key_column_usage
SELECT *
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs';

















