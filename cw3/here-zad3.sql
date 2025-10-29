CREATE TABLE IF NOT EXISTS streets_reprojected AS
SELECT
    t.*,
    ST_Transform(t.geom, 3068) AS geom_reprojected
FROM T2019_KAR_STREETS t;