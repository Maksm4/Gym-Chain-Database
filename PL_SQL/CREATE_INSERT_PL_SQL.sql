--pl/SQL
CREATE TABLE Address (
    ID integer  NOT NULL,
    postal_code varchar2(10)  NOT NULL,
    city varchar2(30)  NOT NULL,
    street varchar2(30)  NOT NULL,
    "number" integer  NOT NULL,
    CONSTRAINT Address_pk PRIMARY KEY (ID)
) ;
-- Table: Certificate
CREATE TABLE Certificate (
    ID integer  NOT NULL,
    name varchar2(30)  NOT NULL,
    date_of_acquiring date  NOT NULL,
    CONSTRAINT Certificate_pk PRIMARY KEY (ID)
) ;

-- Table: Exercise_type
CREATE TABLE Exercise_type (
    ID integer  NOT NULL,
    name varchar2(100)  NOT NULL,
    CONSTRAINT Exercise_type_pk PRIMARY KEY (ID)
) ;

-- Table: Customer
CREATE TABLE Customer (
    ID integer  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (ID)
) ;

-- Table: Employee
CREATE TABLE Employee (
    ID integer  NOT NULL,
    hire_date date  NOT NULL,
    salary integer  NOT NULL,
    Position_ID integer  NOT NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (ID)
) ;


-- Table: Facility
CREATE TABLE Facility (
    ID integer  NOT NULL,
    name varchar2(30)  NOT NULL,
    date_of_start date  NOT NULL,
    contact_number varchar2(9)  NOT NULL,
    email varchar2(100)  NOT NULL,
    manager_ID integer  NOT NULL,
    Address_ID integer  NOT NULL,
    CONSTRAINT Facility_pk PRIMARY KEY (ID)
) ;
-- Table: Facility_Trainer
CREATE TABLE Facility_Trainer (
    Facility_ID integer  NOT NULL,
    Trainer_ID integer  NOT NULL,
    CONSTRAINT Facility_Trainer_pk PRIMARY KEY (Facility_ID,Trainer_ID)
) ;

-- Table: Gym_equipment
CREATE TABLE Gym_equipment (
    ID integer  NOT NULL,
    name varchar2(30)  NOT NULL,
    quantity integer  NOT NULL,
    date_when_bought date  NOT NULL,
    Facility_ID integer  NOT NULL,
    CONSTRAINT Gym_equipment_pk PRIMARY KEY (ID)
) ;

-- Table: Human
CREATE TABLE Human (
    ID integer  NOT NULL,
    name varchar2(30)  NOT NULL,
    surname varchar2(30)  NOT NULL,
    contact_number varchar2(9)  NOT NULL,
    email varchar2(100)  NOT NULL,
    date_of_birth date  NOT NULL,
    Address_ID integer  NOT NULL,
    CONSTRAINT Human_pk PRIMARY KEY (ID)
) ;

-- Table: Membership
CREATE TABLE Membership (
    ID integer  NOT NULL,
    "start" date  NOT NULL,
    end date  NOT NULL,
    Membership_type_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    Payment_status_ID integer  NOT NULL,
    CONSTRAINT Membership_pk PRIMARY KEY (ID)
) ;

-- Table: Membership_type
CREATE TABLE Membership_type (
    ID integer  NOT NULL,
    description varchar2(200)  NOT NULL,
    price integer  NOT NULL,
    requirements varchar2(200)  NOT NULL,
    duration integer  NOT NULL,
    CONSTRAINT Membership_type_pk PRIMARY KEY (ID)
) ;

-- Table: Payment_status
CREATE TABLE Payment_status (
    ID integer  NOT NULL,
    name varchar2(30)  NOT NULL,
    CONSTRAINT Payment_status_pk PRIMARY KEY (ID)
) ;

-- Table: Position
CREATE TABLE Position (
    ID integer  NOT NULL,
    title varchar2(30)  NOT NULL,
    CONSTRAINT Position_pk PRIMARY KEY (ID)
) ;

-- Table: Session_Customer
CREATE TABLE Session_Customer (
    Training_session_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    check_in timestamp  NOT NULL,
    check_out timestamp  NULL,
    CONSTRAINT Session_Customer_pk PRIMARY KEY (Training_session_ID,Customer_ID)
) ;

-- Table: Trainer
CREATE TABLE Trainer (
    ID integer  NOT NULL,
    Certificate_ID integer  NOT NULL,
    CONSTRAINT Trainer_pk PRIMARY KEY (ID)
) ;

-- Table: Training_session
CREATE TABLE Training_session (
    ID integer  NOT NULL,
    Exercise_type_ID integer  NOT NULL,
    start_time timestamp  NOT NULL,
    end_time timestamp  NOT NULL,
    Facility_ID integer  NOT NULL,
    Trainer_ID integer  NOT NULL,
    CONSTRAINT Training_session_pk PRIMARY KEY (ID)
) ;


-- foreign keys
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
ALTER TABLE Facility_Trainer ADD CONSTRAINT Facility_Trainer
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
ALTER TABLE Session_Customer ADD CONSTRAINT Session_Customer
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

--------------------------------------------
INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (1,'05-500', 'Warsaw', 'Pulawska', 26);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (2, '10-200', 'Krakow', 'Krakowska', 15);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (3, '20-300', 'Gdansk', 'Gdanska', 7);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (4, '30-400', 'Wroclaw', 'Wroclawska', 42);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (5, '40-500', 'Poznan', 'Poznanska', 19);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (6, '50-600', 'Katowice', 'Katowicka', 31);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (7, '60-700', 'Szczecin', 'Szczecinska', 8);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (8, '70-800', 'Lublin', 'Lubelska', 23);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (9, '80-900', 'Gdynia', 'Gdynska', 12);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (10, '90-100', 'Bydgoszcz', 'Bydgoska', 17);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (11, '01-200', 'Rzeszow', 'Rzeszowska', 29);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (12, '02-300', 'Bialystok', 'Bialostocka', 14);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (13, '03-400', 'Czestochowa', 'Czestochowska', 33);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (14, '04-500', 'Sopot', 'Sopocka', 22);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (15, '05-600', 'Olsztyn', 'Olsztynska', 11);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (16, '05-670', 'Warszawa', 'Bobrowiecka', 42);

INSERT INTO Address(ID, postal_code, city, street, "number")
VALUES (17, '05-450', 'Bialystok', 'dluga', 68);

---------inserting to human table
INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (1,'Maksymilian', 'Madagascar', '687321875', 'maks.madagascar@gmail.com', TO_DATE('2004-02-18', 'YYYY-MM-DD'), 1);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (2, 'John', 'Doe', '123456789', 'john.doe@example.com', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 2);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (3, 'Jane', 'Smith', '987654321', 'jane.smith@example.com', TO_DATE('1985-08-22', 'YYYY-MM-DD'), 3);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (4, 'Michael', 'Johnson', '555666777', 'michael.johnson@example.com', TO_DATE('1995-11-10', 'YYYY-MM-DD'), 4);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (5, 'Emily', 'Williams', '777888999', 'emily.williams@example.com', TO_DATE('1980-04-25', 'YYYY-MM-DD'), 5);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (6, 'Daniel', 'Brown', '111222333', 'daniel.brown@example.com', TO_DATE('1992-07-31', 'YYYY-MM-DD'), 6);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (7, 'Sophia', 'Jones', '444555666', 'sophia.jones@example.com', TO_DATE('1988-09-12', 'YYYY-MM-DD'), 7);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (8, 'Ethan', 'Miller', '666777888', 'ethan.miller@example.com', TO_DATE('1998-03-08', 'YYYY-MM-DD'), 8);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (9, 'Olivia', 'Davis', '222333444', 'olivia.davis@example.com', TO_DATE('1982-06-19', 'YYYY-MM-DD'), 9);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (10, 'Liam', 'Taylor', '999000111', 'liam.taylor@example.com', TO_DATE('1993-12-05', 'YYYY-MM-DD'), 10);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (11, 'Ava', 'Johnson', '333444555', 'ava.johnson@example.com', TO_DATE('1991-02-28', 'YYYY-MM-DD'), 11);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (12, 'Noah', 'Anderson', '777888999', 'noah.anderson@example.com', TO_DATE('1987-07-14', 'YYYY-MM-DD'), 12);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (13, 'Emma', 'Brown', '111222333', 'emma.brown@example.com', TO_DATE('1994-09-08', 'YYYY-MM-DD'), 13);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (14, 'Oliver', 'Miller', '555666777', 'oliver.miller@example.com', TO_DATE('1984-04-01', 'YYYY-MM-DD'), 14);

INSERT INTO human(ID, name, surname, contact_number, email, date_of_birth, address_ID)
VALUES (15, 'Sophia', 'Davis', '999111222', 'sophia.davis@example.com', TO_DATE('1999-11-20', 'YYYY-MM-DD'), 15);


----------------------------------
--payment status

INSERT INTO Payment_status(ID, name)
VALUES (1, 'paid');

INSERT INTO Payment_status(ID, name)
VALUES (2, 'processing');

INSERT INTO Payment_status(ID, name)
VALUES (3, 'failure to pay');

----------------------------------------Position

INSERT INTO Position(ID, title)
VALUES (1, 'MANAGER');

INSERT INTO Position(ID, title)
VALUES (2, 'RECEPCIONIST');

INSERT INTO Position(ID, title)
VALUES (3, 'MARKETING SPECIALIST');

INSERT INTO Position(ID, title)
VALUES (4, 'PERSONAL TRAINER');

INSERT INTO Position(ID, title)
VALUES (5, 'CLEANING STAFF');


----------------------------------------Certificate
INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (1,'NASM',TO_DATE('2011-01-10', 'YYYY-MM-DD'));

INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (2,'ACE',TO_DATE('2018-05-25', 'YYYY-MM-DD'));

INSERT INTO Certificate(ID, name, date_of_acquiring)
VALUES (3,'ACSM',TO_DATE('2016-06-17', 'YYYY-MM-DD'));


----------------------------------------

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES(1, TO_DATE('2019-09-16', 'YYYY-MM-DD'), 4700, 2 );

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (2, TO_DATE('2020-05-22', 'YYYY-MM-DD'), 8000, 1);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (3, TO_DATE('2021-01-10', 'YYYY-MM-DD'), 6500, 1);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (4, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 7200, 2);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (5, TO_DATE('2022-03-18', 'YYYY-MM-DD'), 4000, 4);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (6, TO_DATE('2020-08-30', 'YYYY-MM-DD'), 5500, 3);

INSERT INTO Employee(ID, hire_date, salary, position_ID)
VALUES (7, TO_DATE('2022-03-18', 'YYYY-MM-DD'), 4500, 4);

-------------------------------------------

INSERT INTO Trainer(ID, certificate_ID)
VALUES (5, 1);

INSERT INTO Trainer(ID, certificate_ID)
VALUES (7, 3);

---------------------------------------

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
------------------------------

INSERT INTO Facility(ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
VALUES (1,'NPARK',TO_DATE('2012-05-23', 'YYYY-MM-DD'), '666666666', 'npark.gym@gmail.com', 2, 16);

INSERT INTO Facility(ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
VALUES (2,'PAWIA',TO_DATE('2007-03-11', 'YYYY-MM-DD'), '999999999','pawia.gym@gmail.com', 3, 17);


---------------------------

INSERT INTO Gym_equipment(ID, name, quantity,date_when_bought, facility_ID)
VALUES (1,'barbells',50,TO_DATE('2017-01-23', 'YYYY-MM-DD'), 1);

INSERT INTO Gym_equipment(ID, name, quantity,date_when_bought, facility_ID)
VALUES (2,'treadmill',12,TO_DATE('2019-09-29', 'YYYY-MM-DD'), 1);

INSERT INTO Gym_equipment(ID, name, quantity,date_when_bought, facility_ID)
VALUES (3,'pull up bar',8,TO_DATE('2015-08-06', 'YYYY-MM-DD'), 2);

INSERT INTO Gym_equipment(ID, name, quantity,date_when_bought, facility_ID)
VALUES (4,'curl bar',5,TO_DATE('2020-07-16', 'YYYY-MM-DD'), 2);

INSERT INTO Gym_equipment(ID, name, quantity,date_when_bought, facility_ID)
VALUES (5,'leg extension',3,TO_DATE('2022-11-14', 'YYYY-MM-DD'), 1);

----------------------------------

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (1,'standard month', 200, 'none', 1);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (2,'student month', 160, 'student ID', 1);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (3,'standard year', 2000, 'none', 12);

INSERT INTO Membership_type(ID, description, price, requirements, duration)
VALUES (4,'Student year', 1700, 'student ID', 12);

----------------------------------------

INSERT INTO Membership (ID, "start", end, membership_type_ID, customer_ID, payment_status_ID)
VALUES (1, TO_DATE('2020-04-01', 'YYYY-MM-DD'),TO_DATE('2020-05-01', 'YYYY-MM-DD'), 1, 8, 1);

INSERT INTO Membership (ID, "start", end, membership_type_ID, customer_ID, payment_status_ID)
VALUES (2, TO_DATE('2018-02-01', 'YYYY-MM-DD'),TO_DATE('2019-02-01', 'YYYY-MM-DD'), 4, 9, 1);

INSERT INTO Membership (ID, "start", end, membership_type_ID, customer_ID, payment_status_ID)
VALUES (3, TO_DATE('2019-08-01', 'YYYY-MM-DD'),TO_DATE('2019-09-01', 'YYYY-MM-DD'), 2, 10, 3);

INSERT INTO Membership (ID, "start", end, membership_type_ID, customer_ID, payment_status_ID)
VALUES (4, TO_DATE('2021-01-01', 'YYYY-MM-DD'),TO_DATE('2022-01-01', 'YYYY-MM-DD'), 3, 11, 3);

INSERT INTO Membership (ID, "start", end, membership_type_ID, customer_ID, payment_status_ID)
VALUES (5, TO_DATE('2017-05-01', 'YYYY-MM-DD'),TO_DATE('2018-05-01', 'YYYY-MM-DD'), 3, 12, 2);

-----------------------

INSERT INTO Facility_Trainer (facility_ID,trainer_ID)
VALUES (1,5);

INSERT INTO Facility_Trainer (facility_ID,trainer_ID)
VALUES (1,7);

INSERT INTO Facility_Trainer (facility_ID,trainer_ID)
VALUES (2,5);

---------------------------exercise_type

INSERT INTO Exercise_type(ID, name)
VALUES (1, 'CARDIO');


INSERT INTO Exercise_type(ID, name)
VALUES (2, 'YOGA');


INSERT INTO Exercise_type(ID, name)
VALUES (3, 'CALISTHENICS');

---------------------------

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (1, TO_DATE('2021-06-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 5, 1);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (2, TO_DATE('2021-07-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 5, 2);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (3, TO_DATE('2021-04-29 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-04-29 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 5, 1);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (4, TO_DATE('2021-02-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-02-28 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 7, 3);

INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (5, TO_DATE('2020-01-13 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-01-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 7, 2);

----------------------------------------

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (1,8,  TO_DATE('2022-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_DATE('2022-06-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (2,8,   TO_DATE('2021-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-01-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (3,9,  TO_DATE('2023-03-20 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-03-20 18:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (3,11, TO_DATE('2019-04-25 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-25 22:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (4,13, TO_DATE('2018-05-30 23:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-05-31 01:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (5,12,  TO_DATE('2023-04-29 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_DATE('2023-04-29 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));