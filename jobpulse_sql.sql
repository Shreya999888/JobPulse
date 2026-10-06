CREATE DATABASE jobpulse1;

USE jobpulse1;
SELECT DATABASE();
USE jobpulse1;

CREATE TABLE vacancies (
    id INT PRIMARY KEY,
    created_at DATETIME,
    title VARCHAR(255),
    company VARCHAR(255),
    source_url TEXT,
    description_raw TEXT,
    experience_years DECIMAL(5,2),
    published_at DATETIME,
    location VARCHAR(255),
    experience_level VARCHAR(100),
    created_date DATE,
    created_year INT,
    created_month INT,
    description_available TINYINT,
    experience_years_status VARCHAR(50),
    location_clean VARCHAR(255),
    experience_level_clean VARCHAR(100),
    skill_count INT,
    skill_mapping_status VARCHAR(50)
);



CREATE TABLE skills (
    id INT PRIMARY KEY,
    created_at DATETIME,
    name VARCHAR(255),
    skill_name VARCHAR(255),
    skill_name_standard VARCHAR(255)
);

CREATE TABLE vacancy_skills (
    vacancy_id INT NOT NULL,
    skill_id INT NOT NULL,

    PRIMARY KEY (vacancy_id, skill_id),

    FOREIGN KEY (vacancy_id)
        REFERENCES vacancies(id),

    FOREIGN KEY (skill_id)
        REFERENCES skills(id)
);
SELECT COUNT(*) FROM vacancies;

SELECT COUNT(*) FROM skills;

SELECT COUNT(*) FROM vacancy_skills;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';


LOAD DATA LOCAL INFILE 'C:/Users/Admin/vacancies_clean.csv'
INTO TABLE vacancies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) AS skill_count
FROM skills;

SELECT VERSION();
SELECT USER();
SELECT DATABASE();
DESCRIBE vacancies;
DESCRIBE skills;
DESCRIBE vacancy_skills;
SELECT COUNT(*) AS skill_count
FROM skills;
SELECT COUNT(*) AS vacancy_count
FROM vacancies;
SELECT COUNT(*) AS vacancy_skill_count
FROM vacancy_skills;
SELECT COUNT(*) AS invalid_vacancies
FROM vacancy_skills vs
LEFT JOIN vacancies v
    ON vs.vacancy_id = v.id
WHERE v.id IS NULL;
SELECT COUNT(*) AS invalid_skills
FROM vacancy_skills vs
LEFT JOIN skills s
    ON vs.skill_id = s.id
WHERE s.id IS NULL;
SELECT
    s.skill_name_standard AS skill,
    COUNT(DISTINCT vs.vacancy_id) AS job_count
FROM vacancy_skills vs
JOIN skills s
    ON vs.skill_id = s.id
GROUP BY s.skill_name_standard
ORDER BY job_count DESC
LIMIT 10;
SELECT
    experience_level_clean AS experience_level,
    COUNT(*) AS job_count
FROM vacancies
GROUP BY experience_level_clean
ORDER BY job_count DESC;
SELECT
    location_clean AS location,
    COUNT(*) AS job_count
FROM vacancies
GROUP BY location_clean
ORDER BY job_count DESC
LIMIT 15;
SELECT
    YEAR(published_at) AS year,
    COUNT(*) AS job_count
FROM vacancies
WHERE published_at IS NOT NULL
GROUP BY YEAR(published_at)
ORDER BY year;
SELECT
    YEAR(published_at) AS year,
    MONTH(published_at) AS month,
    COUNT(*) AS job_count
FROM vacancies
WHERE published_at IS NOT NULL
GROUP BY
    YEAR(published_at),
    MONTH(published_at)
ORDER BY
    year,
    month;SELECT
    company,
    COUNT(*) AS job_count
FROM vacancies
WHERE company IS NOT NULL
  AND TRIM(company) <> ''
GROUP BY company
ORDER BY job_count DESC
LIMIT 15;
SELECT
    s.skill_name_standard AS skill,
    COUNT(DISTINCT vs.vacancy_id) AS job_count
FROM vacancies v
JOIN vacancy_skills vs
    ON v.id = vs.vacancy_id
JOIN skills s
    ON vs.skill_id = s.id
WHERE LOWER(v.experience_level_clean) = 'entry level'
GROUP BY s.skill_name_standard
ORDER BY job_count DESC
LIMIT 15;
SELECT
    v.location_clean AS location,
    s.skill_name_standard AS skill,
    COUNT(DISTINCT v.id) AS job_count
FROM vacancies v
JOIN vacancy_skills vs
    ON v.id = vs.vacancy_id
JOIN skills s
    ON vs.skill_id = s.id
GROUP BY
    v.location_clean,
    s.skill_name_standard
ORDER BY
    v.location_clean,
    job_count DESC;
WITH skill_location_demand AS (
    SELECT
        v.location_clean AS location,
        s.skill_name_standard AS skill,
        COUNT(DISTINCT v.id) AS job_count
    FROM vacancies v
    JOIN vacancy_skills vs
        ON v.id = vs.vacancy_id
    JOIN skills s
        ON vs.skill_id = s.id
    GROUP BY
        v.location_clean,
        s.skill_name_standard
),

ranked_skills AS (
    SELECT
        location,
        skill,
        job_count,
        RANK() OVER (
            PARTITION BY location
            ORDER BY job_count DESC
        ) AS skill_rank
    FROM skill_location_demand
)

SELECT
    location,
    skill,
    job_count,
    skill_rank
FROM ranked_skills
WHERE skill_rank <= 5
ORDER BY
    location,
    skill_rank;
    
SELECT
    s1.skill_name_standard AS skill_1,
    s2.skill_name_standard AS skill_2,
    COUNT(DISTINCT vs1.vacancy_id) AS job_count
FROM vacancy_skills vs1
JOIN vacancy_skills vs2
    ON vs1.vacancy_id = vs2.vacancy_id
    AND vs1.skill_id < vs2.skill_id
JOIN skills s1
    ON vs1.skill_id = s1.id
JOIN skills s2
    ON vs2.skill_id = s2.id
GROUP BY
    s1.skill_name_standard,
    s2.skill_name_standard
ORDER BY job_count DESC
LIMIT 20;
WITH skill_level_demand AS (
    SELECT
        v.experience_level_clean AS experience_level,
        s.skill_name_standard AS skill,
        COUNT(DISTINCT v.id) AS job_count
    FROM vacancies v
    JOIN vacancy_skills vs
        ON v.id = vs.vacancy_id
    JOIN skills s
        ON vs.skill_id = s.id
    GROUP BY
        v.experience_level_clean,
        s.skill_name_standard
),

ranked_skills AS (
    SELECT
        experience_level,
        skill,
        job_count,
        RANK() OVER (
            PARTITION BY experience_level
            ORDER BY job_count DESC
        ) AS skill_rank
    FROM skill_level_demand
)

SELECT
    experience_level,
    skill,
    job_count,
    skill_rank
FROM ranked_skills
WHERE skill_rank <= 10
ORDER BY
    experience_level,
    skill_rank;
SELECT
    YEAR(v.published_at) AS year,
    s.skill_name_standard AS skill,
    COUNT(DISTINCT v.id) AS job_count
FROM vacancies v
JOIN vacancy_skills vs
    ON v.id = vs.vacancy_id
JOIN skills s
    ON vs.skill_id = s.id
WHERE v.published_at IS NOT NULL
GROUP BY
    YEAR(v.published_at),
    s.skill_name_standard
ORDER BY
    year,
    job_count DESC;
SELECT
    YEAR(v.published_at) AS year,
    s.skill_name_standard AS skill,
    COUNT(DISTINCT v.id) AS job_count
FROM vacancies v
JOIN vacancy_skills vs
    ON v.id = vs.vacancy_id
JOIN skills s
    ON vs.skill_id = s.id
WHERE v.published_at IS NOT NULL
GROUP BY
    YEAR(v.published_at),
    s.skill_name_standard
ORDER BY
    year,
    job_count DESC;
WITH yearly_skill_demand AS (
    SELECT
        YEAR(v.published_at) AS year,
        s.skill_name_standard AS skill,
        COUNT(DISTINCT v.id) AS job_count
    FROM vacancies v
    JOIN vacancy_skills vs
        ON v.id = vs.vacancy_id
    JOIN skills s
        ON vs.skill_id = s.id
    WHERE v.published_at IS NOT NULL
    GROUP BY
        YEAR(v.published_at),
        s.skill_name_standard
),

skill_growth AS (
    SELECT
        year,
        skill,
        job_count,
        LAG(job_count) OVER (
            PARTITION BY skill
            ORDER BY year
        ) AS previous_year_jobs
    FROM yearly_skill_demand
)

SELECT
    year,
    skill,
    job_count,
    previous_year_jobs,
    job_count - previous_year_jobs AS change_in_jobs
FROM skill_growth
ORDER BY
    skill,
    year;
SELECT
    company,
    experience_level_clean AS experience_level,
    COUNT(*) AS job_count
FROM vacancies
WHERE company IS NOT NULL
  AND TRIM(company) <> ''
GROUP BY
    company,
    experience_level_clean
ORDER BY
    company,
    job_count DESC;
WITH company_level_demand AS (
    SELECT
        experience_level_clean AS experience_level,
        company,
        COUNT(*) AS job_count
    FROM vacancies
    WHERE company IS NOT NULL
      AND TRIM(company) <> ''
    GROUP BY
        experience_level_clean,
        company
),

ranked_companies AS (
    SELECT
        experience_level,
        company,
        job_count,
        RANK() OVER (
            PARTITION BY experience_level
            ORDER BY job_count DESC
        ) AS company_rank
    FROM company_level_demand
)

SELECT
    experience_level,
    company,
    job_count,
    company_rank
FROM ranked_companies
WHERE company_rank <= 5
ORDER BY
    experience_level,
    company_rank;
SELECT
    id,
    title,
    company,
    location_clean,
    experience_level_clean,
    skill_count,
    skill_mapping_status
FROM vacancies
WHERE skill_mapping_status = 'No skills mapped'
ORDER BY id;
SELECT
    skill_mapping_status,
    description_available,
    COUNT(*) AS job_count
FROM vacancies
GROUP BY
    skill_mapping_status,
    description_available
ORDER BY
    skill_mapping_status,
    description_available;
SELECT
    s.skill_name_standard AS skill,
    COUNT(DISTINCT v.id) AS job_count
FROM vacancies v
JOIN skills s
    ON LOWER(v.description_raw) LIKE CONCAT(
        '%',
        LOWER(s.skill_name_standard),
        '%'
    )
WHERE v.skill_mapping_status = 'No skills mapped'
  AND v.description_available = 1
GROUP BY s.skill_name_standard
ORDER BY job_count DESC
LIMIT 20;
SELECT
    COUNT(*) AS total_jobs,

    COUNT(DISTINCT company) AS companies_hiring,

    SUM(
        CASE
            WHEN LOWER(experience_level_clean) = 'entry level'
            THEN 1
            ELSE 0
        END
    ) AS entry_level_jobs,

    SUM(
        CASE
            WHEN skill_mapping_status = 'Skills mapped'
            THEN 1
            ELSE 0
        END
    ) AS jobs_with_skills_mapped,

    SUM(
        CASE
            WHEN skill_mapping_status = 'No skills mapped'
            THEN 1
            ELSE 0
        END
    ) AS jobs_without_skill_mapping,

    ROUND(AVG(experience_years), 2) AS avg_required_experience

FROM vacancies;
CREATE OR REPLACE VIEW jobpulse_skill_demand AS
SELECT
    v.id AS vacancy_id,
    v.title,
    v.company,
    v.location_clean AS location,
    v.experience_level_clean AS experience_level,
    v.experience_years,
    v.published_at,
    v.created_year,
    v.created_month,
    v.description_available,
    v.skill_count,
    v.skill_mapping_status,
    s.id AS skill_id,
    s.skill_name_standard AS skill
FROM vacancies v
JOIN vacancy_skills vs
    ON v.id = vs.vacancy_id
JOIN skills s
    ON vs.skill_id = s.id;
SELECT *
FROM jobpulse_skill_demand
LIMIT 10;
CREATE OR REPLACE VIEW jobpulse_vacancy_summary AS
SELECT
    id AS vacancy_id,
    title,
    company,
    location_clean AS location,
    experience_level_clean AS experience_level,
    experience_years,
    published_at,
    created_date,
    created_year,
    created_month,
    description_available,
    skill_count,
    skill_mapping_status
FROM vacancies;
SELECT *
FROM jobpulse_vacancy_summary
LIMIT 10;
SELECT COUNT(*) AS total_vacancies
FROM jobpulse_vacancy_summary;