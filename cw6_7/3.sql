CREATE TABLE blazenek.intersection AS
SELECT
  a.rid,
  (ST_Intersection(b.geom, a.rast)).geom AS geom,
  (ST_Intersection(b.geom, a.rast)).val AS val
FROM rasters.landsat8 AS a,
     vectors.porto_parishes AS b
WHERE b.parish ILIKE 'paranhos'
  AND ST_Intersects(b.geom, a.rast);

CREATE TABLE blazenek.dumppolygons AS
SELECT
  a.rid,
  (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).geom AS geom,
  (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).val AS val
FROM rasters.landsat8 AS a,
     vectors.porto_parishes AS b
WHERE b.parish ILIKE 'paranhos'
  AND ST_Intersects(b.geom, a.rast);