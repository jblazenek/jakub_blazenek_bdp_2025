INSERT INTO obiekty (nazwa, geometria) VALUES (
    'obiekt2',
    ST_GeomFromEWKT(
        'CURVEPOLYGON(
            COMPOUNDCURVE(
                (10 6, 14 6),
                CIRCULARSTRING(14 6, 16 4, 14 2),
                CIRCULARSTRING(14 2, 12 0, 10 2),
                (10 2, 10 6)
            ),
            COMPOUNDCURVE(
                CIRCULARSTRING(11 2, 12 2, 13 2),
                CIRCULARSTRING(13 2, 12 1, 11 2)
            )
        )'
    )
);