/*
    Returns the most in-demand skills overall for remote Data Analyst and Data Scientist jobs
*/


SELECT *
FROM (
    SELECT	
        job_title_short,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROW_NUMBER() OVER (PARTITION BY job_title_short ORDER BY COUNT(skills_job_dim.job_id) DESC) AS rank
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short IN ('Data Analyst', 'Data Scientist')
        AND job_work_from_home = TRUE 
    GROUP BY
        job_title_short,
        skills
) ranked
WHERE rank <= 10;
