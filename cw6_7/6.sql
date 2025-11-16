CREATE TABLE blazenek.tpi30 AS
SELECT ST_TPI(a.rast, 1) AS rast
FROM rasters.dem AS a;

CREATE INDEX idx_tpi30_rast_gist
ON blazenek.tpi30
USING gist (ST_ConvexHull(rast));

CREATE TABLE blazenek.tpi30_porto AS
SELECT ST_TPI(a.rast, 1) AS rast
FROM rasters.dem AS a,
     vectors.porto_parishes AS b
WHERE ST_Intersects(a.rast, b.geom)
  AND b.municipality ILIKE 'porto';

CREATE TABLE blazenek.porto_ndvi AS
WITH r AS (
    SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
    FROM rasters.landsat8 AS a, vectors.porto_parishes AS b
    WHERE b.municipality ILIKE 'porto'
      AND ST_Intersects(b.geom, a.rast)
)
SELECT
    r.rid,
    ST_MapAlgebra(
        r.rast, 1,
        r.rast, 4,
        '([rast2.val] - [rast1.val]) / ([rast2.val] + [rast1.val])::float',
        '32BF'
    ) AS rast
FROM r;

CREATE INDEX idx_porto_ndvi_rast_gist ON blazenek.porto_ndvi
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('blazenek'::name, 'porto_ndvi'::name, 'rast'::name);

CREATE OR REPLACE FUNCTION blazenek.ndvi(
    value double precision [] [] [],
    pos integer [] [],
    VARIADIC userargs text []
)
RETURNS double precision AS
$$
BEGIN
    RETURN (value [2][1][1] - value [1][1][1]) /
           (value [2][1][1] + value [1][1][1]);
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE COST 1000;

CREATE TABLE blazenek.porto_ndvi2 AS
WITH r AS (
    SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
    FROM rasters.landsat8 AS a, vectors.porto_parishes AS b
    WHERE b.municipality ILIKE 'porto'
      AND ST_Intersects(b.geom, a.rast)
)
SELECT
    r.rid,
    ST_MapAlgebra(
        r.rast, ARRAY[1,4],
        'blazenek.ndvi(double precision[], integer[], text[])'::regprocedure,
        '32BF'::text
    ) AS rast
FROM r;