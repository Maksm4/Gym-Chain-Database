-- foreign keys
ALTER TABLE Customer
    DROP CONSTRAINT Customer_Human;

ALTER TABLE Session_Customer
    DROP CONSTRAINT Customer_Training_session;

ALTER TABLE Employee
    DROP CONSTRAINT Employee_Human;

ALTER TABLE Employee
    DROP CONSTRAINT Employee_Position;

ALTER TABLE Facility
    DROP CONSTRAINT Facility_Employee;

ALTER TABLE Facility_Trainer
    DROP CONSTRAINT Facility_Facility;

ALTER TABLE Facility
    DROP CONSTRAINT Facility_Localisation;

ALTER TABLE Facility_Trainer
    DROP CONSTRAINT Facility_Trainer;

ALTER TABLE Gym_equipment
    DROP CONSTRAINT Gym_equipment_Facility;

ALTER TABLE Human
    DROP CONSTRAINT Human_Address;

ALTER TABLE Membership
    DROP CONSTRAINT Membership_Customer;

ALTER TABLE Membership
    DROP CONSTRAINT Membership_Membership_type;

ALTER TABLE Membership
    DROP CONSTRAINT Membership_Payment_status;

ALTER TABLE Session_Customer
    DROP CONSTRAINT Session_Customer;

ALTER TABLE Training_session
    DROP CONSTRAINT TExercise;

ALTER TABLE Trainer
    DROP CONSTRAINT Trainer_Certificate;

ALTER TABLE Trainer
    DROP CONSTRAINT Trainer_Employee;

ALTER TABLE Training_session
    DROP CONSTRAINT facility_trainer_ts;

-- tables
DROP TABLE Address;

DROP TABLE Certificate;

DROP TABLE Customer;

DROP TABLE Employee;

DROP TABLE Exercise_type;

DROP TABLE Facility;

DROP TABLE Facility_Trainer;

DROP TABLE Gym_equipment;

DROP TABLE Human;

DROP TABLE Membership;

DROP TABLE Membership_type;

DROP TABLE Payment_status;

DROP TABLE Position;

DROP TABLE Session_Customer;

DROP TABLE Trainer;

DROP TABLE Training_session;

-- End of file.