    OVERVIEW  
The gym database is a relational database that is designed to manage information related to employees, customers and gym equipment,
it also allows us to store information about the types and plans of memberships including the status payment of the specific customers membership.
The database takes care of keeping the track of the training sessions with each trainer and possibly multiple customers including the time of the session
as well as the time of the check in and check out of the customer. Additionally it tells us about what equipment,
and when was bought for the specific facility and which trainers are giving training sessions at that facility.
It is written in PL/SQL as well as T-SQL dialects in their dedicated folders with diffrent triggers and prcoedures that could have
a real use in a real life database. In addition there is provided a png(created in vertabelo) file with a visualization of the database and relations
between tables. If needed there is also provided a drop table file that deletes the relations and tables from the database.

    RELATIONS:
The human table has 0 to 1 relationship to employees and customers, which means that a single person can be either an employee or a customer. It has 7 columns that are shared by them, which are:

- An unique ID of each human that is inherited by either employee or customer.(PK)

- Name, surname, contact number, email address and the date of birth

- Address_ID which is a foreign key from address table and stores the specific information where the person lives.

The Address table stores the information where someone lives or where the facility is located. It has the following columns:

- A unique ID(PK)

- Postal code, city, street and a house number

The customer table other than the foreign key ID from the human table that is also a primary key of this table, doesn’t have any columns.

The employee table just as the customer table inherits the unique ID from the human table and has 3 additional columns:

- Position_ID which is a foreign key of Position table

- hire_date and salary

The position table acts as a dictionary that stores the available positions an employee can have.

- A unique ID (PK)

- Title(type of position)

The trainer table is inheriting from the employee table and has an additional column other than the unique ID and all the other columns inherited from employee so also from human:

- Certificate_ID which is a foreign key from the certificate table

Certificate table tells us about the names of the certificates and when they were acquired. The columns:

- A unique ID(PK)

- Name (type of certificate)

- Date_of_acquiring

The facility manages information about each location of the gym and has columns as:

- An unique ID of each facility(PK)

- Name, email address, contact number, date of start

- Address_ID which is a foreign key from the address table

- Manager_ID which is a foreign key from the employee table that designates a manager for each facility.

The gym_equipment table allows us to get information about the equipment at each facility. When It was bought as well in what quantity.

- An unique ID of every batch of equipment(PK)

- Name, quantity, date_when_bought

- Facility_ID a foreign key from the facility table that tells us where the equipment is at.

The facility_Trainer table has a many to many relationship and works as a joining table to allow each facility to have multiple trainers as well each trainer to work at multiple facilities. The columns are:

- Facility_ID which is a foreign key from facility and the primary key at the same time

- Trainer_ID which is also a foreign key but from trainer table and the primary key at the same time

Exercise_type table stores information about the possible types a session can have, for example cardio or calisthenics.

- A unique ID(PK)

- Name(type of workout)

The training_session table is used to store information about the sessions. When they occurred, who was the trainer as well as where they were conducted at. The columns are:

- An unique ID of every session(PK)

- Start_time, end_time

- Facility_ID which is a foreign key from facility and tells us where the sessions happened at.

- Trainer_ID which is also a foreign key and tells us which trainer conducted the classes.

- Exercise_type_ID which is also a foreign key and tells the type of the session it is.

Session_customer table is as well as facility_trainer used as a joining table to ensure the many to many relationship between customer and training session. It allows us to have many customers at a session as well the same customer at many different sessions. The columns are:

- Training_session_ID is a foreign key but also a primary key

- Customer_ID is a foreign key but also a primary key

- As well as check in and check out(N) information as timestamps

Membership_type table manages the types of memberships we can choose from and for how long a customer wants to buy the specific membership. The columns:

- An unique ID of each type(PK)

- Description acts as a name of the subscription

- Price

- Requirements which are for example to be a student

- Duration in months of the membership

Payment_status table gives us the information about the status of the payment for the membership.

- An unique ID for each status(PK)

- Name: for example paid, processing etc.

Membership table manages information regarding customer memberships and the information about them that includes:

- An unique ID for each membership(PK)

- Membership_type_ID which is a foreign key from the membership_type table and provides additional information about the membership

- Customer_ID which is a foreign key from the customer table and gives us the information to who does the membership belong

- Payment_status_ID which is a foreign key from the payment_status table

- Start, end dates to know when did the membership start and when it ends

      TRIGGERS(infrmation about each trigger and what's it purpose in the sql files):
Triggers are a kind of procedure that is executed every time a specific action occures. For example before inserting an entry to the specific table.
- CREATE OR REPLACE means that if a trigger with that name  already exists it would be replaced by this trigger and if it doesn't \
 it will just create the trigger
- BEFORE INSERT OR UDPATE This keyword means that the trigger should be fired before the execution of the create or update action taken on
  some table
- ON means which table should a trigger operate on.
- there is also a check case provided for each trigger to make sure it is working properly
  
      PROCEDURES(infrmation about each prcoedure and what's it purpose in the sql files):
  Procedures in SQL are reusable sets of SQL statements  
- there is also a check case provided for each procedure to make sure it is working properly

