create table state_growth_rate as
SELECT
    state,
    vehicle_category,
    current_year,
    current_year_sales,
    previous_year_sales,
    growth_rate
FROM (
    SELECT 
        e1.state,
        e1.vehicle_category,
        e1.year AS current_year,
        e1.total_sales AS current_year_sales,
        e2.total_sales AS previous_year_sales,
        CASE 
            WHEN e2.total_sales = 0 THEN NULL
            ELSE ((e1.total_sales - e2.total_sales) / e2.total_sales) * 100 
        END AS growth_rate
    FROM 
        yearly_sales e1
    JOIN 
        yearly_sales e2
    ON 
        e1.state = e2.state
        AND e1.year = e2.year + 1
) AS growth_data
WHERE growth_rate IS NOT NULL;