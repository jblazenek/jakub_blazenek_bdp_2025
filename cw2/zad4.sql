CREATE TABLE IF NOT EXISTS buildings (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(Polygon),
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS roads (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(LineString),
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS poi (
    id SERIAL PRIMARY KEY,
    geometry GEOMETRY(Point),
    name VARCHAR(50)
);