SELECT ST_SummaryStats(a.rast) AS stats
FROM blazenek.paranhos_dem AS a;

SELECT ST_SummaryStats(ST_Union(a.rast))
FROM blazenek.paranhos_dem AS a;

WITH t AS (
  SELECT ST_SummaryStats(ST_Union(a.rast)) AS stats
  FROM blazenek.paranhos_dem AS a
)
SELECT (stats).min, (stats).max, (stats).mean FROM t;

WITH t AS (
  SELECT b.parish AS parish,
         ST_SummaryStats(ST_Union(ST_Clip(a.rast, b.geom, true))) AS stats
  FROM rasters.dem AS a,
       vectors.porto_parishes AS b
  WHERE b.municipality ILIKE 'porto'
    AND ST_Intersects(b.geom, a.rast)
  GROUP BY b.parish
)
SELECT parish, (stats).min, (stats).max, (stats).mean
FROM t;

SELECT b.name,
       ST_Value(a.rast, (ST_Dump(b.geom)).geom)
FROM rasters.dem AS a,
     vectors.places AS b
WHERE ST_Intersects(a.rast, b.geom)
ORDER BY b.name;