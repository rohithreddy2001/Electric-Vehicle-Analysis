create table peak_to_low_months_ev_sales as
SELECT 
	d.fiscal_year,
    e.vehicle_category,
    MONTH(d.date) AS month,
    maker,
    SUM(electric_vehicles_sold) AS total_ev_sales
FROM
    electric_vehicle_sales_by_makers e
join dim_date d using (date)
where 
	d.fiscal_year between 2022 and 2024
GROUP BY d.fiscal_year,month, maker, e.vehicle_category
ORDER BY maker, total_ev_sales desc;