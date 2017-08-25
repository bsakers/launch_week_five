DROP TABLE movies CASCADE;
DROP TABLE categories CASCADE;

CREATE TABLE movies (
  id serial primary key,
  title varchar(255),
  year integer,
  category_id integer
);

CREATE TABLE categories (
  id serial primary key,
  name varchar(255)
);

CREATE UNIQUE INDEX ON movies (year, title);
CREATE UNIQUE INDEX ON categories (name);
