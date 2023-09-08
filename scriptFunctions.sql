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
CREATE OR REPLACE FUNCTION getLocations() RETURNS SETOF deviceLocation AS 
	$$
	SELECT * from DeviceLocation;
	$$
Language SQL;

--Update Device Location
CREATE OR REPLACE FUNCTION modifyDeviceLocation(located_old varchar, located_new varchar, latitude_new varchar, longitude_new varchar) RETURNS void AS 
	$$
	--Creates a new input on the table
	INSERT into DeviceLocation (located, latitude, longitude) values (located_new, latitude_new, longitude_new);
	
	--Updates quality devices that used the old location
	UPDATE QualityDevice
	SET	located = located_new
	WHERE located = located_old;
	
	--Deletes old location from device location
	DELETE FROM DeviceLocation WHERE located = located_old;
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


--*****Quality Device table*****
--Add a new Quality device
CREATE OR REPLACE FUNCTION addQualityDevice(idDevice integer, ip varchar, mac varchar, tolerance float, phoneNumber varchar, idFrequency integer, located varchar) RETURNS void AS 
	$$
	insert into QualityDevice values (idDevice, ip, mac, tolerance, phoneNumber, idFrequency, located);
	$$
Language SQL;

--Update a Quality Device
CREATE OR REPLACE FUNCTION modifyQualityDevice(idDevice_r integer, ip_new varchar, mac_new varchar, tolerance_new float,
											   phoneNumber_new varchar, idFrequency_new integer, located_new varchar) RETURNS void AS 
	$$
	UPDATE QualityDevice set ip = ip_new, mac = mac_new, tolerance = tolerance_new, phoneNumber = phoneNumber_new,
	idFrequency = idFrequency_new, located = located_new
	WHERE idDevice = idDevice_r;
	$$
Language SQL;

--Get the last quality device created according to the highest id
CREATE OR REPLACE FUNCTION getLastQualityDevice() RETURNS QualityDevice AS
	$$
	select * from QualityDevice
	order by idDevice desc;
	$$
Language SQL;

--Get all the quality devices created
CREATE OR REPLACE FUNCTION getQualityDevices() RETURNS SETOF QualityDevice AS
	$$
	select * from QualityDevice
	$$
Language SQL;







