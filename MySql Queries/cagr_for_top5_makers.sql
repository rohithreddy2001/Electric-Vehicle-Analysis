CREATE TABLE CAGR_for_top5_makers AS
(
WITH ev_sales AS (
    SELECT 
        d.fiscal_year,
        maker,
        vehicle_category,
        SUM(electric_vehicles_sold) AS total_ev_sales
    FROM
        electric_vehicle_sales_by_makers e
    JOIN 
        dim_date d USING (date)
    WHERE
        vehicle_category LIKE '4%'
        AND d.fiscal_year IN (2022, 2023, 2024)
    GROUP BY d.fiscal_year, maker, vehicle_category
)
SELECT 
    e1.maker,
    e1.vehicle_category,
    e1.fiscal_year,
    e1.total_ev_sales,
    CASE 
        WHEN e1.fiscal_year = 2024 AND e2.total_ev_sales IS NOT NULL AND e2.total_ev_sales > 0 THEN
            (POWER(e1.total_ev_sales / e2.total_ev_sales, 1.0 / (e1.fiscal_year - e2.fiscal_year)) - 1) * 100
        ELSE NULL
    END AS cagr
FROM 
    ev_sales e1
LEFT JOIN 
    ev_sales e2 
    ON e1.maker = e2.maker 
    AND e2.fiscal_year = 2022
ORDER BY 
    e1.maker,
    e1.vehicle_category
)
UNION
(
WITH ev_sales AS (
    SELECT 
        d.fiscal_year,
        maker,
        vehicle_category,
        SUM(electric_vehicles_sold) AS total_ev_sales
    FROM
        electric_vehicle_sales_by_makers e
    JOIN 
        dim_date d USING (date)
    WHERE
        vehicle_category LIKE '2%'
        AND d.fiscal_year IN (2022, 2023, 2024)
    GROUP BY d.fiscal_year, maker, vehicle_category
)
SELECT 
    e1.maker,
    e1.vehicle_category,
    e1.fiscal_year,
    e1.total_ev_sales,
    CASE 
        WHEN e1.fiscal_year = 2024 AND e2.total_ev_sales IS NOT NULL AND e2.total_ev_sales > 0 THEN
            (POWER(e1.total_ev_sales / e2.total_ev_sales, 1.0 / (e1.fiscal_year - e2.fiscal_year)) - 1) * 100
        ELSE NULL
    END AS cagr
FROM 
    ev_sales e1
LEFT JOIN 
    ev_sales e2 
    ON e1.maker = e2.maker 
    AND e2.fiscal_year = 2022
ORDER BY 
    e1.maker,
    e1.vehicle_category
);
