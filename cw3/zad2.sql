SELECT ST_Area(
    ST_Buffer(
        ST_ShortestLine(
            (SELECT geometria FROM obiekty WHERE nazwa = 'obiekt3'),
            (SELECT geometria FROM obiekty WHERE nazwa = 'obiekt4')
        ),
        5
    )
);