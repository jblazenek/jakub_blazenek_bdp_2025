SELECT SUM(
    ST_Area(
        ST_Buffer(geometria, 5)
    )
)
FROM obiekty
WHERE NOT ST_HasArc(geometria);