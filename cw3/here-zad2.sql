WITH new_buildings AS (
    SELECT t19.geom
    FROM t2019_kar_buildings t19
    LEFT JOIN t2018_kar_buildings t18
        ON ST_Equals(t19.geom, t18.geom)
    WHERE t18.gid IS NULL
)
SELECT t19_poi.type, COUNT(*) AS ilosc
FROM t2019_kar_poi_table t19_poi
LEFT JOIN t2018_kar_poi_table t18_poi
    ON ST_Equals(t19_poi.geom, t18_poi.geom)
WHERE t18_poi.gid IS NULL
AND EXISTS (
    SELECT 1
    FROM new_buildings nb
    WHERE ST_DWithin(t19_poi.geom::geography, nb.geom::geography, 500)
)
GROUP BY t19_poi.type;