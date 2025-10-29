INSERT INTO obiekty (nazwa, geometria)
SELECT
    'obiekt7',
    ST_Collect(o3.geometria, o4.geometria)
FROM
    obiekty o3, obiekty o4
WHERE
    o3.nazwa = 'obiekt3' AND o4.nazwa = 'obiekt4';