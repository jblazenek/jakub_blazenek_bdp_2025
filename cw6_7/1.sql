CREATE TABLE blazenek.intersects AS
SELECT a.rast, b.municipality
FROM rasters.dem AS a, vectors.porto_parishes AS b
WHERE ST_Intersects(a.rast, b.geom)
  AND b.municipality ILIKE 'porto';

ALTER TABLE blazenek.intersects
ADD COLUMN rid SERIAL PRIMARY KEY;

CREATE INDEX idx_intersects_rast_gist
ON blazenek.intersects
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('blazenek'::name, 'intersects'::name, 'rast'::name);

CREATE TABLE blazenek.clip AS
SELECT ST_Clip(a.rast, b.geom, true) AS rast, b.municipality
FROM rasters.dem AS a, vectors.porto_parishes AS b
WHERE ST_Intersects(a.rast, b.geom)
  AND b.municipality ILIKE 'porto';

CREATE TABLE blazenek.union AS
SELECT ST_Union(ST_Clip(a.rast, b.geom, true)) AS rast
FROM rasters.dem AS a, vectors.porto_parishes AS b
WHERE b.municipality ILIKE 'porto'
  AND ST_Intersects(b.geom, a.rast);
