
--CLIENTS
--Client: client_id 
Declare

	NullValues EXCEPTION;

	PRAGMA EXCEPTION_INIT(NullValues, -01400);

BEGIN

	INSERT INTO Client
	(pClient,cClient)
VALUES
	(NULL, NULL);
	DBMS_OUTPUT.PUT_LINE('NOT NULL Constraint not functionnal');
	
	
EXCEPTION

	WHEN NullValues
		THEN DBMS_OUTPUT.PUT_LINE('NOT NULL Constraint functionnal');
	
	WHEN OTHERS
		THEN DBMS_OUTPUT.PUT_LINE('error occured during validation');
		
	END;
    

