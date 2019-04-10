CREATE OR REPLACE VIEW Inventory AS SELECT
    m.id AS Material_id,
    m.name AS Material_name,
    COALESCE(SUM(r.qty), 0) - COALESCE(SUM(c.qty), 0) AS qty
FROM
    Material AS m
LEFT JOIN Restock_View AS r
ON
    r.Material_id = m.id
LEFT JOIN Consumption_View AS c
ON
    c.Material_id = m.id
WHERE
    r.Material_id = c.Material_id
