SELECT name
FROM buildings
WHERE ST_Y(ST_Centroid(geometry)) > 4.5;