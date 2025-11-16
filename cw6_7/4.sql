CREATE TABLE blazenek.landsat_nir AS
SELECT rid, ST_Band(rast, 4) AS rast
FROM rasters.landsat8;

CREATE TABLE blazenek.paranhos_dem AS
SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
FROM rasters.dem AS a,
     vectors.porto_parishes AS b
WHERE b.parish ILIKE 'paranhos'
  AND ST_Intersects(b.geom, a.rast);

CREATE TABLE blazenek.paranhos_slope AS
SELECT a.rid, ST_Slope(a.rast, 1, '32BF', 'PERCENTAGE') AS rast
FROM blazenek.paranhos_dem AS a;

CREATE TABLE blazenek.paranhos_slope_reclass AS
SELECT a.rid,
       ST_Reclass(a.rast, 1, ']0-15]:1,(15-30]:2,(30-9999]:3', '32BF', 0) AS rast
FROM blazenek.paranhos_slope AS a;