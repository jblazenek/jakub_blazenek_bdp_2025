ALTER TABLE input_points
ALTER COLUMN geom TYPE GEOMETRY(Point, 3068)
USING ST_Transform(geom, 3068);