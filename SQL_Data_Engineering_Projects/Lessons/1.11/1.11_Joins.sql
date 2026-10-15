-- LEFT JOIN

SELECT
    jf.job_id,
    jf.job_title_short,
    cd.company_id,
    cd.name as company_name,
    jf.job_location
FROM job_postings_fact as jf
LEFT JOIN company_dim as cd
    ON jf.company_id = cd.company_id
LIMIT 10;



-- EX LEFT JOIN
SELECT
    jpf.job_id,
    jpf.job_title_short,
    sd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;


SELECT
    COUNT(*)
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;



-- EX INNER JOIN

SELECT
    COUNT(*)
FROM job_postings_fact AS jpf
JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id;


SELECT
    jpf.job_id,
    jpf.job_title_short,
    sd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf
JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;










