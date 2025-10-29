CREATE TABLE IF NOT EXISTS obiekty (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(50),
    geometria GEOMETRY
);
