WITH linia AS (
    SELECT ST_MakeLine(geom ORDER BY id) AS geom
    FROM input_points
)
SELECT n.*
FROM t2019_kar_street_node n, linia l
WHERE ST_DWithin(
    ST_Transform(n.geom, 3068),
    l.geom,
    200
);