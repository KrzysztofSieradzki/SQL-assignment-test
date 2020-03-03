WITH 
table_a as(SELECT DISTINCT a.dimension_1, map.dimension_2, a.measure_1 FROM a
LEFT JOIN map ON a.dimension_1 = map.dimension_1 ) ,

aggregated_a as(SELECT a.dimension_1, sum(a.measure_1) as measure_1 FROM table_a as a group by a.dimension_1),

table_b as (SELECT DISTINCT b.dimension_1, map.dimension_2, b.measure_2 FROM b
LEFT JOIN map ON b.dimension_1 = map.dimension_1),

aggregated_b as (SELECT b.dimension_1, sum(b.measure_2) as measure_2 FROM table_b as b group by b.dimension_1)

SELECT a.dimension_1, tabA.dimension_2, ifnull(a.measure_1,0) as measure_1, ifnull(b.measure_2,0) as measure_2 
FROM aggregated_a as a LEFT JOIN aggregated_b as b ON a.dimension_1 = b.dimension_1 
JOIN table_a as tabA ON a.dimension_1 = tabA.dimension_1 
UNION
SELECT b.dimension_1, tabB.dimension_2, ifnull(a.measure_1,0) as measure_1, ifnull(b.measure_2,0) as measure_2 
FROM aggregated_b as b LEFT JOIN aggregated_a as a ON a.dimension_1 = b.dimension_1 
JOIN table_b as tabB ON b.dimension_1 = tabB.dimension_1;