--*****User table*****
--Create new user
CREATE OR REPLACE FUNCTION addUser (UserName_r varchar, Name_r varchar, FirstLastName_r varchar, SecondLastName_r varchar, Email_r varchar, PhoneNumber_r varchar,
										 Password_r varchar) RETURNS void AS $$
	DECLARE
		EncodedPassword varchar;
	Begin
		SELECT crypt(Password_r, gen_salt('bf', 4)) into EncodedPassword;

	insert into Users(userName,name,firstLastName,secondLastName,email,phoneNumber,password) 
	values (UserName_r, Name_r,FirstLastName_r,SecondLastName_r,Email_r, PhoneNumber_r, EncodedPassword );
END;
$$ LANGUAGE plpgsql;

--Validate user
CREATE OR REPLACE FUNCTION validateUser(UserName_r varchar, Password_r varchar) RETURNS Users AS 
	$$
	(SELECT * FROM USERS WHERE UserName_r = UserName and Password = crypt(Password_r, Password))
	$$
Language SQL;


--Modify user
CREATE OR REPLACE FUNCTION modifyUser (UserName_r varchar, Name_r varchar, FirstLastName_r varchar, SecondLastName_r varchar, Email_r varchar, PhoneNumber_r varchar,
										 Password_r varchar) RETURNS void AS $$
	DECLARE
		EncodedPassword VARCHAR;
	BEGIN
		SELECT crypt(Password_r, gen_salt('bf', 4)) into EncodedPassword;
	UPDATE users
	SET UserName = UserName_r, Name = Name_r, FirstLastName = FirstLastName_r, SecondLastName = SecondLastName_r, Email = Email_r, PhoneNumber = PhoneNumber_r, Password = EncodedPassword
	WHERE UserName = UserName_r;
	END;
	$$
LANGUAGE plpgsql;

--*****Device Location table*****
--Add a new device location
CREATE OR REPLACE FUNCTION addDeviceLocation(located_r varchar, latitude_r varchar, longitude_r varchar) RETURNS void AS 
	$$
	insert into DeviceLocation (located, latitude, longitude) values (located_r, latitude_r, longitude_r);
	$$
Language SQL;

--Get locations
CREATE OR REPLACE FUNCTION getLocations() RETURNS deviceLocation AS 
	$$
	SELECT * from DeviceLocation;
	$$
Language SQL;

--Update Device Location
CREATE OR REPLACE FUNCTION modifyDeviceLocation(located_old varchar, located_new varchar, latitude_new varchar, longitude_new varchar) RETURNS void AS 
	$$
	UPDATE DeviceLocation
	SET	located = located_new, latitude = latitude_new, longitude = longitude_new
	WHERE located = located_old;
	$$
Language SQL;

--*****Frequencies table*****
--Add a new device location
CREATE OR REPLACE FUNCTION addFrequency(idFrequency_r integer, meassureFrequency_r float, sendFrequency_r float, messageFrequency_r float) RETURNS void AS 
	$$
	insert into Frequencies values (idFrequency_r, meassureFrequency_r, sendFrequency_r, messageFrequency_r);
	$$
Language SQL;

--Get frequencies
CREATE OR REPLACE FUNCTION getFrequencies() RETURNS SETOF Frequencies AS 
	$$
	select * from Frequencies;
	$$
Language SQL;

--Update Frequencies
CREATE OR REPLACE FUNCTION modifyFrequencies(idFrequency_r integer, meassureFrequency_r float, sendFrequency_r float, messageFrequency_r float) RETURNS void AS
	$$
	UPDATE Frequencies
	SET	meassureFrequency = meassureFrequency_r, sendFrequency = sendFrequency_r, messageFrequency = messageFrequency_r
	WHERE idFrequency = idFrequency_r;
	$$
Language SQL;

