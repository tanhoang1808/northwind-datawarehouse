
WITH RECURSIVE date_array AS (
    SELECT 
        DATE('2001-01-01') AS time_stamp
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, time_stamp) 
    FROM date_array
    WHERE time_stamp < DATE('2060-01-01')
)
SELECT 
    time_stamp,
    DAY(time_stamp) as day_of_month,
    DAYOFWEEK(time_stamp) as day_of_week,
    YEAROFWEEK(time_stamp) as year_or_week,
    DAYNAME(time_stamp) as day_name,
    WEEKISO(time_stamp) as weekISO,
    DATE_TRUNC('month',time_stamp) as first_day_of_month,
    WEEKISO(DATE_TRUNC('month',time_stamp)) as first_week_of_month,
    CASE
        WHEN WEEKISO(time_stamp) < WEEKISO(DATE_TRUNC('month',time_stamp)) 
        THEN (WEEKISO(time_stamp) + 53) - WEEKISO(DATE_TRUNC('month',time_stamp)) + 1 
        ELSE WEEKISO(time_stamp) - WEEKISO(DATE_TRUNC('month',time_stamp)) + 1 
    END AS week_of_month,
    MONTHNAME(time_stamp) as month_name,
    QUARTER(time_stamp) as quarter,
    YEAR(time_stamp) as year
FROM date_array
