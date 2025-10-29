SELECT COUNT(DISTINCT poi.gid) AS n
FROM t2019_kar_poi_table poi
JOIN t2019_kar_land_use_a parks
    ON ST_DWithin(poi.geom::geography, parks.geom::geography, 300)
WHERE poi.type = 'Sporting Goods Store';