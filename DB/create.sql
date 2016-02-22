CREATE TABLE movies (
  id INTEGER PRIMARY KEY,
  title TEXT,
  -- rating INTEGER,
  director_id INTEGER
);

CREATE TABLE genres (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE directors (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE actors (
  id INTEGER PRIMARY KEY,
  name TEXT);

CREATE TABLE movies_actors (
  id INTEGER PRIMARY KEY,
  movie_id INTEGER,
  actor_id INTEGER
);

CREATE TABLE movies_genres (
  id INTEGER PRIMARY KEY,
  movie_id INTEGER,
  genre_id INTEGER
);

CREATE TABLE actors_genres (
  id INTEGER PRIMARY KEY,
  actor_id INTEGER,
  genre_id INTEGER
);

CREATE TABLE actors_directors (
  id INTEGER PRIMARY KEY,
  actor_id INTEGER,
  director_id INTEGER
);

CREATE TABLE directors_genres (
  id INTEGER PRIMARY KEY,
  director_id INTEGER,
  genre_id INTEGER
);
