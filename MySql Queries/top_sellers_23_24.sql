create table top_sellers_23_24 as
(
SELECT 
    d.fiscal_year,e.maker, e.vehicle_category, sum(e.electric_vehicles_sold) as total_ev_sales
FROM
    dim_date d
        JOIN
    electric_vehicle_sales_by_makers e USING (date)
WHERE
    d.fiscal_year in (2022,2023,2024) and e.vehicle_category like "2-%"
group by maker,d.fiscal_year, vehicle_category
order by total_ev_sales desc 
)
union
(
SELECT 
    d.fiscal_year,e.maker, e.vehicle_category, sum(e.electric_vehicles_sold) as total_ev_sales
FROM
    dim_date d
        JOIN
    electric_vehicle_sales_by_makers e USING (date)
WHERE
    d.fiscal_year in (2022,2023,2024) and e.vehicle_category like "4-%"
group by maker,d.fiscal_year, vehicle_category
order by total_ev_sales desc 
)