CREATE TABLE Address(
  Id SERIAL PRIMARY KEY,
  streetAddress VARCHAR,
  city VARCHAR,
  province VARCHAR,
  postalCode VARCHAR
);

CREATE TABLE DonorIndividual (
  Id SERIAL PRIMARY KEY,
  firstName VARCHAR,
  lastName VARCHAR,
  addressId SERIAL REFERENCES Address(Id),
  neighbourhood VARCHAR,
  email VARCHAR,
  phoneNumber VARCHAR
);

CREATE TABLE DonorOrganization (
  Id SERIAL PRIMARY KEY,
  name VARCHAR,
  contactFirstName VARCHAR,
  contactLastName VARCHAR,
  addressId SERIAL REFERENCES Address(Id),
  email VARCHAR,
  phoneNumber VARCHAR,
  website VARCHAR,
  hasDonated BOOLEAN
);