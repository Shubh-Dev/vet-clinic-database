/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

-- day-2

ALTER TABLE animals ADD column species VARCHAR(50);

--Day-3

CREATE TABLE owners (id INT GENERATED ALWAYS AS IDENTITY NOT NULL, full_name VARCHAR(100), age INTEGER, PRIMARY KEY(id));

CREATE TABLE species (id INT GENERATED ALWAYS AS IDENTITY NOT NULL, name VARCHAR(100), PRIMARY KEY(id));

ALTER TABLE animals DROP column species;

ALTER TABLE animals ADD column species_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD column owner_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

-- day-4

CREATE TABLE vets(
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL,
    date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    species_id INTEGER,
    vet_id INTEGER,
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE visits ( mhyhn  vcd
    animal_id INTEGER,
    vet_id INTEGER,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

-- Week - 2 Day - 1

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


CREATE INDEX index_animal_id ON visits (animal_id);

CREATE INDEX index_vet_id ON visits (vet_id ASC NULLS last);

CREATE INDEX index_email ON owners (email ASC NULLS last);
