SELECT ST_Area(
    ST_Difference(
        (SELECT geometry FROM buildings WHERE name = 'BuildingC'),
        ST_Buffer((SELECT geometry FROM buildings WHERE name = 'BuildingB'), 0.5)
    )
) AS area;