UPDATE obiekty
SET geometria = ST_MakePolygon(
    ST_AddPoint(
        geometria,
        ST_StartPoint(geometria)
    )
)
WHERE nazwa = 'obiekt4' AND NOT ST_IsClosed(geometria);