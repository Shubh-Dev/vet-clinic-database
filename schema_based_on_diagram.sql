CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owners_id" INTEGER NOT NULL
);
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
CREATE TABLE "species"(
    "id" INTEGER NOT NULL,
    "name" INTEGER NOT NULL
);
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "owners"(
    "id" INTEGER NOT NULL,
    "full_name" INTEGER NOT NULL,
    "age" INTEGER NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
CREATE TABLE "visits"(
    "id" INTEGER NOT NULL,
    "animal_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date_of_visit" INTEGER NOT NULL
);
CREATE INDEX "visits_animal_id_index" ON
    "visits"("animal_id");
CREATE INDEX "visits_vet_id_index" ON
    "visits"("vet_id");
ALTER TABLE
    "visits" ADD PRIMARY KEY("id");
CREATE TABLE "specialization"(
    "id" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL
);
ALTER TABLE
    "specialization" ADD PRIMARY KEY("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animal_id_foreign" FOREIGN KEY("animal_id") REFERENCES "animals"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "specialization" ADD CONSTRAINT "specialization_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owners_id_foreign" FOREIGN KEY("owners_id") REFERENCES "owners"("id");
ALTER TABLE
    "specialization" ADD CONSTRAINT "specialization_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");