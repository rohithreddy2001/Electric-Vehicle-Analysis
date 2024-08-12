create table Penetration_Rate_states as
SELECT
    e.state,
    e.vehicle_category,
    d.fiscal_year,
    sum(e.electric_vehicles_sold) as ev_sales,
    round((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)),2) AS penetration_rate
FROM
    electric_vehicle_sales_by_state e
join
	dim_date d using (date)
GROUP BY
    e.state, e.vehicle_category, d.fiscal_year
having
    d.fiscal_year in (2022,2023,2024)
ORDER BY
    penetration_rate DESC;
