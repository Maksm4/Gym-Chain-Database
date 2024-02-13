--trigger 1  when an employee is added as a facility manager and
-- his position is not a manager raise an error and stop the insertion
-- it is needed because, ensures us that someone by mistake won't add an employee on the manager position if he is not a manager.

CREATE TRIGGER manager_check ON Facility
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    DECLARE @employeeID INT;
    SELECT @employeeID = manager_ID FROM inserted;

    IF NOT EXISTS(SELECT 1 FROM Employee WHERE Employee.ID = @employeeID
              AND Position_ID = (SELECT ID FROM Position WHERE title = 'MANAGER'))
        BEGIN
            RAISERROR('the employee you are trying to assign as a manager for this facility is not a manager', 10, 1);
            ROLLBACK;
        END;
		ELSE
        BEGIN
            -- Insert or Update operation based on the original query
            INSERT INTO Facility (ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
            SELECT ID, name, date_of_start, contact_number, email, manager_ID, address_ID FROM inserted;
        END;
END;

--check case
INSERT INTO Facility (ID, name, date_of_start, contact_number, email, manager_ID, address_ID)
VALUES (5, 'Gym5', '2023-03-20', '123456789', 'gym3@example.com', 5, 2);




--trigger 2, to check if the certificate is valid of a trainer that is being added to the database. If it's not older than 10 years.
-- it is useful as it doesn't allow us to add a trainer that has an expired certificate.
CREATE TRIGGER check_if_certificate_valid ON Trainer
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    DECLARE @certificateID INT;
    DECLARE @acquired_date DATE;
    DECLARE @certificate_name VARCHAR(30);

    SELECT @certificateID = i.Certificate_ID,
           @acquired_date = c.date_of_acquiring,
           @certificate_name = c.name
    FROM inserted i
    JOIN Certificate c ON i.Certificate_ID = c.ID;

    IF DATEDIFF(YEAR, @acquired_date, GETDATE()) > 10
    BEGIN
        RAISERROR('The certificate has expired: %s', 12, 1, @certificate_name);
    END;
    ELSE
    BEGIN
          INSERT INTO Trainer(ID, Certificate_ID)
            SELECT ID, Certificate_ID FROM inserted;
    END;
END;

-- check case
INSERT INTO Trainer(ID,Certificate_ID)
VALUES (4,1);


--procedure 1 that checks all the existing trainers certificates and displays if they have a valid one or not
-- it is useful to check if our trainer staff is properly trained.

DROP PROCEDURE check_trainer_certificate;

CREATE PROCEDURE check_trainer_certificate
AS
BEGIN
     DECLARE @TrainerID INT;
     DECLARE @Certificate_name VARCHAR(30);
     DECLARE @Acquired_date DATE;
     DECLARE @Curr_date DATE;

     DECLARE cur CURSOR FOR
        SELECT T.ID, c.name AS certificate_name, c.date_of_acquiring
        FROM Trainer t
        JOIN Certificate c ON t.Certificate_ID = c.ID

    OPEN cur;
    FETCH NEXT FROM cur INTO @TrainerID, @Certificate_name, @Acquired_date;

     WHILE @@FETCH_STATUS = 0
     BEGIN
           SET @Curr_date = GETDATE();

           IF DATEDIFF(YEAR, @Acquired_date,@Curr_date) > 10
            BEGIN
                 PRINT 'TrainerID : ' + CAST(@TrainerID AS VARCHAR) + ' Certificate: ' + @certificate_name + ' - has expired';
            END;
            ELSE
            BEGIN
                 PRINT 'TrainerID : ' + CAST(@TrainerID AS VARCHAR) + ' Certificate: ' + @certificate_name + ' - is valid';
            END;
            FETCH NEXT FROM cur INTO @TrainerID,@Certificate_name, @Acquired_date;
     END;
    CLOSE cur;
    DEALLOCATE cur;
END;

--check case
EXEC  check_trainer_certificate;

--procedure 2
-- procedure allows us to delete memberships of customers that have already expired.
--its is useful because, this procedure can be run everyday to check if someones membership expired.

DROP PROCEDURE cancel_memberships;


CREATE PROCEDURE cancel_memberships
AS
BEGIN
    DECLARE @curr_date DATE;
    DECLARE @membership_id INT;
    DECLARE @deleted_memberships INT;
    SET @curr_date = GETDATE();
    SET @deleted_memberships = 0;

    DECLARE cur CURSOR FOR
        SELECT Membership.ID
        FROM Membership
        WHERE [end] < @curr_date;

    OPEN cur;

    FETCH NEXT FROM cur INTO @membership_id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DELETE FROM Membership
        WHERE Membership.ID = @membership_id;
        SET @deleted_memberships += 1;

        FETCH NEXT FROM cur INTO @membership_id;
    END

    CLOSE cur;
    DEALLOCATE cur;

    PRINT 'DELETED memberships: ' + CONVERT(VARCHAR, @deleted_memberships) + ' expired memberships';
END;
-- check case
EXEC cancel_memberships;
