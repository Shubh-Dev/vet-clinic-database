/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'; 

SELECT name FROM animals WHERE neutered = TRUE and escape_attempts < 3;

SELECT date_of_birth FROM animals  WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT name FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.4;

-- day-2


BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT point_1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO point_1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT TRANSACTION;

-- question answer

--1. How many animals are there?

SELECT COUNT(*) FROM animals;

--2. How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

--3. What is the average weight of all animals?

SELECT AVG(weight_kg) FROM animals;

--4. Who escaped the most, neutered or not neutered animals ?

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

--5. What is the minimum and maximum weight of each types of animals?

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

--6. What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- day-3


--What animal belongs to Melody Pond?

SELECT name, full_name FROM animals join owners on animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon(type);

SELECT animals.name FROM animals join species on animals.species_id = species.id WHERE species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name, animals.name FROM owners join animals on owners.id = animals.owner_id;

-- How many animals are there per species ?

SELECT species.name, COUNT(*) FROM species join animals on species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name FROM animals join owners on animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species_id = 2;

-- List all the animals owned by Dean Winchester that haven't tried to escape

SELECT name from animals join owners on animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0; 

-- Who owns the most animals ?

SELECT full_name FROM owners join animals on owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;

--day-4

--Who was the last animal seen by William Tatcher?

SELECT animals.name, animal_id, vet_id, date_of_visit
FROM animals JOIN visits ON animals.id = animal_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
GROUP BY animals.name, animal_id, vet_id, date_of_visit
ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT animals.name, animal_id, vet_id FROM animals JOIN visits ON animals.id = animal_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

-- List all vets and their specialities, including vets with no specialities.

SELECT vets.name, species.name FROM specializations RIGHT JOIN vets ON specializations.vet_id = vets.id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all the animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name AS animal, vets.name AS vet, visits.date_of_visit FROM animals
JOIN visits ON animals.id = animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30'; 

-- What animal has the most visits to vets?

SELECT animals.name, COUNT(*) AS visits FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, vets.name, date_of_visit FROM animals
JOIN visits ON animals.id = animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name, vets.name, date_of_visit FROM animals
JOIN visits ON animals.id = animal_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.id NOT IN (SELECT vet_id FROM specializations WHERE species_id = animals.species_id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT animal_id, animals.species_id, species.name AS speciality FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith';
 

 -- Week- 2 Day-1

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';




