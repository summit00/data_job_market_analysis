/*
    This query calculates the number and percentage of job postings for each job title 
    in the dataset, sorted by the most common roles first.
*/

WITH job_counts AS (
    -- CTE for outputing the absolut number of each job title.
    SELECT
        job_title_short,
        COUNT(job_id) AS count_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        job_title_short
),
total AS (
    -- CTE for calculating the total amount of jobs.
    SELECT 
        SUM(count_jobs) AS total_jobs 
    FROM job_counts
)
SELECT 
    job_counts.job_title_short,
    job_counts.count_jobs,
    ROUND(100.0 * job_counts.count_jobs / total.total_jobs, 2) AS percentage
FROM job_counts, total
ORDER BY job_counts.count_jobs DESC;