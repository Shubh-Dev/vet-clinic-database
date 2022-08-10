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