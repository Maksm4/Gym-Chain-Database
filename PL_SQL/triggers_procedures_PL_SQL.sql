-- trigger 1
-- checks when adding a session with a trainer if this trainer is having at that time some other training sessions
-- if he does it raises an error
-- it is usefull because it prevents us from adding multiple sessions for the same trainer at the overlapping time
CREATE OR REPLACE TRIGGER Prevent_Session_overlap
BEFORE INSERT OR UPDATE 
ON Training_session
FOR EACH ROW
DECLARE overlap_count NUMBER;
BEGIN 
    SELECT COUNT(*)
    INTO overlap_count
    FROM Training_session
    WHERE Trainer_ID = :NEW.Trainer_ID
    	AND :NEW.start_time < end_time 
    	AND :NEW.end_time > start_time;


	IF overlap_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20998, 'You are trying to add a session that would overlap with already existing one');
    END IF;
END;


--check case
INSERT INTO Training_session (ID, start_time, end_time, facility_ID, trainer_ID, exercise_type_ID)
VALUES (6, TO_DATE('2020-01-13 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-01-13 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 7, 2);


-- trigger 2
-- check if the check out date is later then the check in date
-- it is a useful trigger as it prevents us from adding a check out date earlier than the check in date as it's not possible in real life it shouldn't be possible in the database
-- it also checks if the check out time is considerably too long and raises an error
CREATE OR REPLACE TRIGGER date_integrity
BEFORE INSERT OR UPDATE 
ON Session_customer
FOR EACH ROW
DECLARE 
    wierdly_long_time_max CONSTANT INTEGER := 2;
	days_diff INTEGER;
BEGIN 
	IF  :NEW.check_out IS NOT NULL 
    	AND :NEW.check_out <= :NEW.check_in THEN
    	RAISE_APPLICATION_ERROR(-20997, 'check-out time must be later then check-in time');
	END IF;

	days_diff := EXTRACT(DAY FROM :NEW.check_out - :NEW.check_in);
	IF days_diff > wierdly_long_time_max THEN
        RAISE_APPLICATION_ERROR(-20996, 'check-out weirdly too long');
    END IF;
END;


--check case
INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (5,14,  TO_DATE('2023-04-29 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_DATE('2023-05-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Session_Customer (training_session_ID, customer_ID, check_in, check_out)
VALUES (5,15,  TO_DATE('2023-04-29 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_DATE('2023-04-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

--procedure 1 checks if the customer has paid for his membership
--the procedure is needed as it checks if the customer has paid for his subscription,
--then if he hasn't we can inform him about in an email.

SET Serveroutput ON;

CREATE OR REPLACE PROCEDURE check_if_paid
	(customerID NUMBER)
AS	
    pay_status VARCHAR(30);
BEGIN 
    SELECT Payment_status.name INTO pay_status
    FROM Payment_status
    JOIN Membership ON Membership.payment_status_ID = Payment_status.ID
    WHERE Membership.customer_ID = customerID;

	IF pay_status = 'paid' THEN
    	DBMS_OUTPUT.PUT_LINE('the customer has paid for the memebrship');  
	ELSIF pay_status = 'processing' THEN
        DBMS_OUTPUT.PUT_LINE('the payment for this customer is currently being processed');  
	ELSIF pay_status = 'failure to pay' THEN
        DBMS_OUTPUT.PUT_LINE('the customer hasn''t paid for the membership');  
	END IF;
END;

--check case
EXEC check_if_paid(9);
EXEC check_if_paid(10);


--procedure 2 with cursor, is used to get the information about all the sessions a specific trainer has conducted
-- additionally we get the most attended type of those sessions that can be a good statistic to maybe do more of this sessions.

CREATE OR REPLACE PROCEDURE Trainer_session_insight
	(TrainerID INTEGER)
AS
	CURSOR cur IS 
		SELECT ts.ID, COUNT(sc.customer_ID) AS people_count , MAX(e.name) AS MAE
		FROM Training_session ts
		JOIN Session_Customer sc ON ts.ID = sc.training_session_ID
        JOIN Exercise_type e ON ts.Exercise_type_ID = e.ID
		WHERE ts.trainer_ID = TrainerID
		GROUP BY ts.ID
		ORDER BY people_count DESC;

	sessionID INTEGER;
	peopleCount INTEGER;
	most_attended_type VARCHAR2(30);
BEGIN 
	OPEN cur;
	LOOP
		FETCH cur INTO sessionID, peopleCount, most_attended_type;
        EXIT WHEN cur%NOTFOUND;

		 DBMS_OUTPUT.PUT_LINE('session ID: ' || sessionID);
		 DBMS_OUTPUT.PUT_LINE('Amount of people: ' || peopleCount);
		 DBMS_OUTPUT.PUT_LINE('---------------------');
	END LOOP;
	CLOSE cur;

	SELECT MAX(e.name) INTO most_attended_type
    FROM Training_Session ts
    JOIN Session_Customer sc ON ts.ID = sc.training_session_ID
    JOIN Exercise_type e ON ts.Exercise_type_ID = e.ID
    WHERE ts.Trainer_ID = TrainerID
    GROUP BY e.ID
    ORDER BY COUNT(sc.Customer_ID) DESC
    FETCH FIRST 1 ROW ONLY;
	DBMS_OUTPUT.PUT_LINE('the most attended type of session is ' || most_attended_type );
END;

--check case
EXEC Trainer_session_insight(5);
