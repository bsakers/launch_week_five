SELECT movies.title, movies.year, movies.category
FROM movies
WHERE movies.year < 2000;

SELECT categories.name
FROM categories;

SELECT movies.title
FROM movies
WHERE movies.id = 4

SELECT movies.title, movies.year
FROM movies
ORDER BY movies.year;

SELECT movies.title, movies.year
FROM movies
ORDER BY movies.title;

SELECT movies.title
FROM movies
LIMIT 5;

SELECT movies.title
FROM movies
ORDER BY movies.year desc
LIMIT 5;

UPDATE categories
SET name = 'Science Fiction'
WHERE name = 'Sci_Fi'

DELETE FROM movies
WHERE id= 3

SELECT movies.title, categories.name AS category
FROM movies
JOIN categories ON movies.category_id = categories.id
ORDER BY movies.title ASC;
