CREATE TABLE blazenek.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem
  LIMIT 1
)
SELECT ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';

DROP TABLE blazenek.porto_parishes;

CREATE TABLE blazenek.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem
  LIMIT 1
)
SELECT ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';

DROP TABLE blazenek.porto_parishes;

CREATE TABLE blazenek.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem
  LIMIT 1
)
SELECT ST_Tile(
         ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)),
         128, 128, true, -32767
       ) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';