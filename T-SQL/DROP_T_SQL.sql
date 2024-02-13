--drop 
ALTER TABLE Facility_Trainer DROP CONSTRAINT IF EXISTS Facility_Trainer;
ALTER TABLE Employee DROP CONSTRAINT IF EXISTS Employee_Position;
ALTER TABLE Facility DROP CONSTRAINT IF EXISTS Facility_Employee;
ALTER TABLE Facility DROP CONSTRAINT IF EXISTS Facility_Localisation;
ALTER TABLE Facility_Trainer DROP CONSTRAINT IF EXISTS Facility_Facility;
ALTER TABLE Gym_equipment DROP CONSTRAINT IF EXISTS Gym_equipment_Facility;
ALTER TABLE Membership DROP CONSTRAINT IF EXISTS Membership_Payment_status;
ALTER TABLE Membership DROP CONSTRAINT IF EXISTS Membership_Membership_type;
ALTER TABLE Membership DROP CONSTRAINT IF EXISTS Membership_Customer;
ALTER TABLE Trainer DROP CONSTRAINT IF EXISTS Trainer_Employee;
ALTER TABLE Trainer DROP CONSTRAINT IF EXISTS Trainer_Certificate;
ALTER TABLE Human DROP CONSTRAINT IF EXISTS Human_Address;
ALTER TABLE Employee DROP CONSTRAINT IF EXISTS Employee_Human;
ALTER TABLE Customer DROP CONSTRAINT IF EXISTS Customer_Human;

-- Drop statements for tables
DROP TABLE  Session_Customer;
DROP TABLE  Training_session;
DROP TABLE  Exercise_type;
DROP TABLE  Facility_Trainer;
DROP TABLE  Trainer;
DROP TABLE  Certificate;
DROP TABLE  Gym_equipment;
DROP TABLE  Facility;
DROP TABLE  Employee;
DROP TABLE  Position;
DROP TABLE  Membership;
DROP TABLE  Membership_type;
DROP TABLE  Payment_status;
DROP TABLE  Customer;
DROP TABLE  Human;
DROP TABLE  Address;
