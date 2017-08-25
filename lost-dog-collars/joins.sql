-- Query 1
SELECT dog_owners.name, lost_dog_collars.dog_name
FROM dog_owners
JOIN lost_dog_collars
ON dog_owners.dog_name = lost_dog_collars.dog_name;

-- Query 2
SELECT lost_dog_collars.dog_name
FROM dog_owners RIGHT OUTER
JOIN lost_dog_collars
ON dog_owners.dog_name = lost_dog_collars.dog_name
WHERE dog_owners.name IS NULL;

--Query 3
SELECT lost_dog_collars.dog_name, dog_owners.name
FROM lost_dog_collars LEFT OUTER
JOIN dog_owners
ON dog_owners.dog_name = lost_dog_collars.dog_name;

--Query 4
SELECT dog_owners.name, dog_owners.dog_name, lost_dog_collars.dog_name AS collar
FROM dog_owners LEFT OUTER
JOIN lost_dog_collars
ON dog_owners.dog_name = lost_dog_collars.dog_name;
