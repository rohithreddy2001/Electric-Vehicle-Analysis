create table delhi_vs_karnataka_PR as
SELECT 
    s.state,
    s.vehicle_category,
    d.fiscal_year,
    sum(s.electric_vehicles_sold) as ev_sales,
    sum(s.total_vehicles_sold) as total_sales,
    round((SUM(s.electric_vehicles_sold) / SUM(s.total_vehicles_sold)) * 100,2) AS penetration_rate
FROM
    electric_vehicle_sales_by_state s join dim_date d using (date)
WHERE
    state IN ('Karnataka' , 'Delhi')
        AND d.fiscal_year in (2022,2023,2024)
group by s.vehicle_category,s.state,d.fiscal_year
order by s.state, penetration_rate desc;
