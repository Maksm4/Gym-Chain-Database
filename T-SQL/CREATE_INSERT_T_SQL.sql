--create
-- Table: Address
CREATE TABLE Address (
    ID int  NOT NULL,
    postal_code varchar(10)  NOT NULL,
    city varchar(30)  NOT NULL,
    street varchar(30)  NOT NULL,
    [number] int  NOT NULL,
    CONSTRAINT Address_pk PRIMARY KEY (ID)
);

-- Table: Certificate
CREATE TABLE Certificate (
    ID int  NOT NULL,
    name varchar(30)  NOT NULL,
    date_of_acquiring date  NOT NULL,
    CONSTRAINT Certificate_pk PRIMARY KEY (ID)
);

-- Table: Exercise_type
CREATE TABLE Exercise_type (
    ID int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT Exercise_type_pk PRIMARY KEY (ID)
);

-- Table: Customer
CREATE TABLE Customer (
    ID int  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (ID)
);

-- Table: Employee
CREATE TABLE Employee (
    ID int  NOT NULL,
    hire_date date  NOT NULL,
    salary int  NOT NULL,
    Position_ID int  NOT NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (ID)
);

-- Table: Facility
CREATE TABLE Facility (
    ID int  NOT NULL,
    name varchar(30)  NOT NULL,
    date_of_start date  NOT NULL,
    contact_number varchar(9)  NOT NULL,
    email varchar(100)  NOT NULL,
    manager_ID int  NOT NULL,
    Address_ID int  NOT NULL,
    CONSTRAINT Facility_pk PRIMARY KEY (ID)
);

-- Table: Facility_Trainer
CREATE TABLE Facility_Trainer (
    Facility_ID int  NOT NULL,
    Trainer_ID int  NOT NULL,
    CONSTRAINT Facility_Trainer_pk PRIMARY KEY (Facility_ID,Trainer_ID)
);

-- Table: Gym_equipment
CREATE TABLE Gym_equipment (
    ID int  NOT NULL,
    name varchar(30)  NOT NULL,
    quantity int  NOT NULL,
    date_when_bought date  NOT NULL,
    Facility_ID int  NOT NULL,
    CONSTRAINT Gym_equipment_pk PRIMARY KEY (ID)
);

-- Table: Human
CREATE TABLE Human (
    ID int  NOT NULL,
    name varchar(30)  NOT NULL,
    surname varchar(30)  NOT NULL,
    contact_number varchar(9)  NOT NULL,
    email varchar(100)  NOT NULL,
    date_of_birth date  NOT NULL,
    Address_ID int  NOT NULL,
    CONSTRAINT Human_pk PRIMARY KEY (ID)
);

-- Table: Membership
CREATE TABLE Membership (
    ID int  NOT NULL,
    [start] date  NOT NULL,
    [end] date  NOT NULL,
    Membership_type_ID int  NOT NULL,
    Customer_ID int  NOT NULL,
    Payment_status_ID int  NOT NULL,
    CONSTRAINT Membership_pk PRIMARY KEY (ID)
);

-- Table: Membership_type
CREATE TABLE Membership_type (
    ID int  NOT NULL,
    description varchar(200)  NOT NULL,
    price int  NOT NULL,
    requirements varchar(200)  NOT NULL,
    duration int  NOT NULL,
    CONSTRAINT Membership_type_pk PRIMARY KEY (ID)
);

-- Table: Payment_status
CREATE TABLE Payment_status (
    ID int  NOT NULL,
    name varchar(30)  NOT NULL,
    CONSTRAINT Payment_status_pk PRIMARY KEY (ID)
);

-- Table: Position
CREATE TABLE Position (
    ID int  NOT NULL,
    title varchar(30)  NOT NULL,
    CONSTRAINT Position_pk PRIMARY KEY (ID)
);

-- Table: Session_Customer
CREATE TABLE Session_Customer (
    Training_session_ID int  NOT NULL,
    Customer_ID int  NOT NULL,
    check_in datetime2  NOT NULL,
    check_out datetime2  NULL,
    CONSTRAINT Session_Customer_pk PRIMARY KEY (Training_session_ID,Customer_ID)
);

-- Table: Trainer
CREATE TABLE Trainer (
    ID int  NOT NULL,
    Certificate_ID int  NOT NULL,
    CONSTRAINT Trainer_pk PRIMARY KEY (ID)
);

-- Table: Training_session
CREATE TABLE Training_session (
    ID int  NOT NULL,
    Exercise_type_ID int  NOT NULL,
    start_time datetime2  NOT NULL,
    end_time datetime2  NOT NULL,
    Facility_ID int  NOT NULL,
    Trainer_ID int  NOT NULL,
    CONSTRAINT Training_session_pk PRIMARY KEY (ID)
);

-- Foreign keys
-- Reference: Customer_Human (table: Customer)
ALTER TABLE Customer ADD CONSTRAINT Customer_Human
    FOREIGN KEY (ID)
    REFERENCES Human (ID);

-- Reference: TExercise (table: Training_session)
ALTER TABLE Training_session ADD CONSTRAINT TExercise
    FOREIGN KEY (Exercise_type_ID)
    REFERENCES Exercise_type (ID);

-- Reference: Customer_Training_session (table: Session_Customer)
ALTER TABLE Session_Customer ADD CONSTRAINT Customer_Training_session
    FOREIGN KEY (Training_session_ID)
    REFERENCES Training_session (ID);

-- Reference: Employee_Human (table: Employee)
ALTER TABLE Employee ADD CONSTRAINT Employee_Human
    FOREIGN KEY (ID)
    REFERENCES Human (ID);

-- Reference: Employee_Position (table: Employee)
ALTER TABLE Employee ADD CONSTRAINT Employee_Position
    FOREIGN KEY (Position_ID)
    REFERENCES Position (ID);

-- Reference: Facility_Employee (table: Facility)
ALTER TABLE Facility ADD CONSTRAINT Facility_Employee
    FOREIGN KEY (manager_ID)
    REFERENCES Employee (ID);

-- Reference: Facility_Facility (table: Facility_Trainer)
ALTER TABLE Facility_Trainer ADD CONSTRAINT Facility_Facility
    FOREIGN KEY (Facility_ID)
    REFERENCES Facility (ID);

-- Reference: Facility_Localisation (table: Facility)
ALTER TABLE Facility ADD CONSTRAINT Facility_Localisation
    FOREIGN KEY (Address_ID)
    REFERENCES Address (ID);

-- Reference: Facility_Trainer (table: Facility_Trainer)
ALTER TABLE Facility_Trainer ADD CONSTRAINT Fac_Trainer
    FOREIGN KEY (Trainer_ID)
    REFERENCES Trainer (ID);

-- Reference: Gym_equipment_Facility (table: Gym_equipment)
ALTER TABLE Gym_equipment ADD CONSTRAINT Gym_equipment_Facility
    FOREIGN KEY (Facility_ID)
    REFERENCES Facility (ID);

-- Reference: Human_Address (table: Human)
ALTER TABLE Human ADD CONSTRAINT Human_Address
    FOREIGN KEY (Address_ID)
    REFERENCES Address (ID);

-- Reference: Membership_Customer (table: Membership)
ALTER TABLE Membership ADD CONSTRAINT Membership_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Membership_Membership_type (table: Membership)
ALTER TABLE Membership ADD CONSTRAINT Membership_Membership_type
    FOREIGN KEY (Membership_type_ID)
    REFERENCES Membership_type (ID);

-- Reference: Membership_Payment_status (table: Membership)
ALTER TABLE Membership ADD CONSTRAINT Membership_Payment_status
    FOREIGN KEY (Payment_status_ID)
    REFERENCES Payment_status (ID);

-- Reference: Session_Customer (table: Session_Customer)
ALTER TABLE Session_Customer ADD CONSTRAINT Sess_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Trainer_Certificate (table: Trainer)
ALTER TABLE Trainer ADD CONSTRAINT Trainer_Certificate
    FOREIGN KEY (Certificate_ID)
    REFERENCES Certificate (ID);

-- Reference: Trainer_Employee (table: Trainer)
ALTER TABLE Trainer ADD CONSTRAINT Trainer_Employee
    FOREIGN KEY (ID)
    REFERENCES Employee (ID);

-- Reference: facility_trainer_ts (table: Training_session)
ALTER TABLE Training_session ADD CONSTRAINT facility_trainer_ts
    FOREIGN KEY (Facility_ID,Trainer_ID)
    REFERENCES Facility_Trainer (Facility_ID,Trainer_ID);

--insert
-- Address table
INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (1, '05-500', 'Warsaw', 'Pulawska', 26);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (2, '10-200', 'Krakow', 'Krakowska', 15);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (3, '20-300', 'Gdansk', 'Gdanska', 7);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (4, '30-400', 'Wroclaw', 'Wroclawska', 42);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (5, '40-500', 'Poznan', 'Poznanska', 19);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (6, '50-600', 'Katowice', 'Katowicka', 31);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (7, '60-700', 'Szczecin', 'Szczecinska', 8);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (8, '70-800', 'Lublin', 'Lubelska', 23);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (9, '80-900', 'Gdynia', 'Gdynska', 12);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (10, '90-100', 'Bydgoszcz', 'Bydgoska', 17);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (11, '01-200', 'Rzeszow', 'Rzeszowska', 29);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (12, '02-300', 'Bialystok', 'Bialostocka', 14);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (13, '03-400', 'Czestochowa', 'Czestochowska', 33);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (14, '04-500', 'Sopot', 'Sopocka', 22);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (15, '05-600', 'Olsztyn', 'Olsztynska', 11);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (16, '05-670', 'Warszawa', 'Bobrowiecka', 42);

INSERT INTO Address(ID, postal_code, city, street, [number])
VALUES (17, '05-450', 'Bialystok', 'dluga', 68);

-- Human table
INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (1, 'Maksymilian', 'Madagascar', '687321875', 'maks.madagascar@gmail.com', '2004-02-18', 1);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (2, 'John', 'Doe', '123456789', 'john.doe@example.com', '1990-05-15', 2);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (3, 'Jane', 'Smith', '987654321', 'jane.smith@example.com', '1985-08-22', 3);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (4, 'Michael', 'Johnson', '555666777', 'michael.johnson@example.com', '1995-11-10', 4);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (5, 'Emily', 'Williams', '777888999', 'emily.williams@example.com', '1980-04-25', 5);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (6, 'Daniel', 'Brown', '111222333', 'daniel.brown@example.com', '1992-07-31', 6);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (7, 'Sophia', 'Jones', '444555666', 'sophia.jones@example.com', '1988-09-12', 7);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (8, 'Ethan', 'Miller', '666777888', 'ethan.miller@example.com', '1998-03-08', 8);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (9, 'Olivia', 'Davis', '222333444', 'olivia.davis@example.com', '1982-06-19', 9);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (10, 'Liam', 'Taylor', '999000111', 'liam.taylor@example.com', '1993-12-05', 10);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (11, 'Ava', 'Johnson', '333444555', 'ava.johnson@example.com', '1991-02-28', 11);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (12, 'Noah', 'Anderson', '777888999', 'noah.anderson@example.com', '1987-07-14', 12);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (13, 'Emma', 'Brown', '111222333', 'emma.brown@example.com', '1994-09-08', 13);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (14, 'Oliver', 'Miller', '555666777', 'oliver.miller@example.com', '1984-04-01', 14);

INSERT INTO Human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (15, 'Sophia', 'Davis', '999111222', 'sophia.davis@example.com', '1999-11-20', 15);


-- Payment_status table
INSERT INTO Payment_status(ID, name)
VALUES (1, 'paid');

INSERT INTO Payment_status(ID, name)
VALUES (2, 'processing');

INSERT INTO Payment_status(ID, name)
VALUES (3, 'failure to pay');


-- Position table
INSERT INTO Position(ID, title)
VALUES (1, 'MANAGER');

INSERT INTO Position(ID, title)
VALUES (2, 'RECEPTIONIST');

INSERT INTO Position(ID, title)
VALUES (3, 'MARKETING SPECIALIST');

INSERT INTO Position(ID, title)
VALUES (4, 'PERSONAL TRAINER');

INSERT INTO Position(ID, title)
VALUES (5, 'CLEANING STAFF');

-- Certificate table
INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (1, 'NASM', '2011-01-10');

INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (2, 'ACE', '2018-05-25');

INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (3, 'ACSM', '2016-06-17');



-- Employee table
INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (1, '2019-09-16', 4700, 2);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (2, '2020-05-22', 8000, 1);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (3, '2021-01-10', 6500, 1);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (4, '2018-11-05', 7200, 2);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (5, '2022-03-18', 4000, 4);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (6, '2020-08-30', 5500, 3);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (7, '2022-03-18', 4500, 4);

-- Trainer table
INSERT INTO Trainer(ID, certificate_ID)
VALUES (5, 1);

INSERT INTO Trainer(ID, certificate_ID)
VALUES (7, 3);

-- Customer table
INSERT INTO Customer(ID)
VALUES (8);

INSERT INTO Customer(ID)
VALUES (9);

INSERT INTO Customer(ID)
VALUES (10);

INSERT INTO Customer(ID)
VALUES (11);

INSERT INTO Customer(ID)
VALUES (12);

INSERT INTO Customer(ID)
VALUES (13);

INSERT INTO Customer(ID)
VALUES (14);

INSERT INTO Customer(ID)
VALUES (15);

-- Facility table
INSERT INTO Facility(ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
VALUES (1, 'NPARK', '2012-05-23', '666666666', 'npark.gym@gmail.com', 2, 16);

INSERT INTO Facility(ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
VALUES (2, 'PAWIA', '2007-03-11', '999999999', 'pawia.gym@gmail.com', 3, 17);

-- Gym_equipment table
INSERT INTO Gym_equipment(ID, name, quantity, date_when_bought, facility_ID)
VALUES (1, 'barbells', 50, '2017-01-23', 1);

INSERT INTO Gym_equipment(ID, name, quantity, date_when_bought, facility_ID)
VALUES (2, 'treadmill', 12, '2019-09-29', 1);

INSERT INTO Gym_equipment(ID, name, quantity, date_when_bought, facility_ID)
VALUES (3, 'pull up bar', 8, '2015-08-06', 2);

INSERT INTO Gym_equipment(ID, name, quantity, date_when_bought, facility_ID)
VALUES (4, 'curl bar', 5, '2020-07-16', 2);

INSERT INTO Gym_equipment(ID, name, quantity, date_when_bought, facility_ID)
VALUES (5, 'leg extension', 3, '2022-11-14', 1);

-- Membership_type table
INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (1, 'standard month', 200, 'none', 1);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (2, 'student month', 160, 'student ID', 1);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (3, 'standard year', 2000, 'none', 12);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (4, 'Student year', 1700, 'student ID', 12);


-- Membership table
INSERT INTO Membership (ID, "start", "end", membership_type_ID, customer_ID, payment_status_ID)
VALUES (1, '2020-04-01', '2020-05-01', 1, 8, 1);

INSERT INTO Membership (ID, "start", "end", membership_type_ID, customer_ID, payment_status_ID)
VALUES (2, '2018-02-01', '2019-02-01', 4, 9, 1);

INSERT INTO Membership (ID, "start", "end", membership_type_ID, customer_ID, payment_status_ID)
VALUES (3, '2019-08-01', '2019-09-01', 2, 10, 3);

INSERT INTO Membership (ID, "start", "end", membership_type_ID, customer_ID, payment_status_ID)
VALUES (4, '2021-01-01', '2022-01-01', 3, 11, 3);

INSERT INTO Membership (ID, "start", "end", membership_type_ID, customer_ID, payment_status_ID)
VALUES (5, '2017-05-01', '2018-05-01', 3, 12, 2);


-- Facility_Trainer table
INSERT INTO Facility_Trainer (facility_ID, trainer_ID)
VALUES (1, 5);

INSERT INTO Facility_Trainer (facility_ID, trainer_ID)
VALUES (1, 7);

INSERT INTO Facility_Trainer (facility_ID, trainer_ID)
VALUES (2, 5);


-- Exercise_type table
INSERT INTO Exercise_type(ID, name)
VALUES (1, 'CARDIO');

INSERT INTO Exercise_type(ID, name)
VALUES (2, 'YOGA');

INSERT INTO Exercise_type(ID, name)
VALUES (3, 'CALISTHENICS');

-- Training_session table
INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (1, '2021-06-11 13:00:00', '2021-06-11 15:00:00', 1, 5, 1);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (2, '2021-07-17 10:00:00', '2021-07-17 11:00:00', 1, 5, 2);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (3, '2021-04-29 15:30:00', '2021-04-29 17:30:00', 2, 5, 1);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (4, '2021-02-28 18:00:00', '2021-02-28 19:00:00', 1, 7, 3);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (5, '2020-01-13 17:00:00', '2020-01-13 18:00:00', 1, 7, 2);


-- Session_Customer table
INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (1, 8, '2022-06-19 10:00:00', '2022-06-19 12:00:00');

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (2, 8, '2021-01-10 10:00:00', '2021-01-10 12:00:00');

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (3, 9, '2023-03-20 16:45:00', '2023-03-20 18:45:00');

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (3, 11, '2019-04-25 20:15:00', '2019-04-25 22:15:00');

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (4, 13, '2018-05-30 23:45:00', '2018-05-31 01:45:00');

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (5, 12, '2023-04-29 10:00:00', '2023-04-29 11:00:00');

