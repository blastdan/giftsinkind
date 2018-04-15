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

/* Agency */
/* These have been tested with a local instance of PosgreSQL. I've included some test data nd select statements. Ken */

/* lookup table AgencyStatus can have only the following values - pending, active, merged */
/*DROP TABLE IF EXISTS AgencyStatus;*/
CREATE TABLE IF NOT EXISTS AgencyStatus (
  asID integer NOT NULL PRIMARY KEY,
  asTextEn varchar(10) NOT NULL /* English text */
);
/*INSERT INTO AgencyStatus (asID, asTextEn) VALUES (1, 'pending'), (2, 'active'), (3, 'merged');*/

/* DROP TABLE IF EXISTS Agency; */
CREATE TABLE IF NOT EXISTS Agency (
  agencyName varchar(80) PRIMARY KEY,
  previousAgencyName varchar(80),
  agencyRepresentative integer NOT NULL,  /* or get this by querying AgencyContact table */
  charityRegistration varchar(80),
  taSigned boolean NOT NULL,
  taDateSigned date NOT NULL,
  status integer NOT NULL REFERENCES AgencyStatus (asID),
  ranking_ThankYou boolean NOT NULL, /* default "good" true */
  ranking_TaxReceipt boolean NOT NULL, /* default "good" true */
  ranking_TimeSinceLastDonation date,
  ranking_Reliability boolean NOT NULL, /* default "good" true */
  ranking_Overall integer NOT NULL, /* default "good" 1 */
  notes varchar(80)
);
/*INSERT INTO Agency (agencyName, agencyRepresentative, taSigned, taDateSigned, status, ranking_ThankYou, ranking_TaxReceipt, ranking_TimeSinceLastDonation, ranking_Reliability, ranking_Overall, notes) VALUES ('My Agency', 123, true, current_timestamp, 1, true, true, current_timestamp, true, 1, 'this is a test'), ('Abc Agency', 124, false, current_timestamp, 2, false, true, current_timestamp, true, 2, 'this is another test');*/

/* AgencyContact */
/*DROP TABLE IF EXISTS AgencyContact;*/
CREATE TABLE IF NOT EXISTS AgencyContact (
  contactID integer NOT NULL PRIMARY KEY,
  contactName varchar(80) NOT NULL,
  contactEmail varchar(80) NOT NULL,
  contactPhone varchar(80) NOT NULL,
  contactMailAddress varchar(80) NOT NULL,
  agencyName varchar(80) NOT NULL REFERENCES Agency(agencyName),
  agencyRep boolean NOT NULL,
  username varchar(80),
  password varchar(80)
);
/*INSERT INTO AgencyContact (contactID, contactName, contactEmail, contactPhone, contactMailAddress, agencyName, agencyRep) VALUES (1, 'Joe Cool', 'joe@cool.com', '123-456-789', '123 Main St., Coolville', 'My Agency', false);*/

/* examples of select statements */
/*
select * from AgencyStatus;
select agencyName, asTextEn from Agency, AgencyStatus;
select agencyName, asTextEn from Agency, AgencyStatus where Agency.status = AgencyStatus.asID;
select contactName, Agency.agencyName from AgencyContact, Agency where AgencyContact.agencyName = Agency.agencyName;
*/

