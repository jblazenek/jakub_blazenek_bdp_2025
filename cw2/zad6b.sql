SELECT
    ST_AsText(geometry) AS wkt,
    ST_Area(geometry) AS area,
    ST_Perimeter(geometry) AS perimeter
FROM buildings
WHERE name = 'BuildingA';