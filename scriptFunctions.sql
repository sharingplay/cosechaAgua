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
	
	--Updates atmospheric devices that used the old location
	UPDATE AtmosphericDevice
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

--Get frequencies by id
CREATE OR REPLACE FUNCTION getFrequency(idFrequency_r integer) RETURNS Frequencies AS 
	$$
	select * from Frequencies where idFrequency = idFrequency_r;
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


--*****Flow Device table*****
--Add flow device
CREATE OR REPLACE FUNCTION addFlowDevice(located varchar, name varchar) RETURNS void AS 
	$$
	insert into FlowDevice(located, name) values (located, name);
	$$
Language SQL;

--Get all flow devices
CREATE OR REPLACE FUNCTION getFlowDevices() RETURNS SETOF FlowDevice AS 
	$$
	SELECT * FROM FlowDevice;
	$$
Language SQL;

--Update flow device
CREATE OR REPLACE FUNCTION modifyFlowDevice(idDevice_r integer, located_new varchar, name_new varchar) RETURNS void AS 
	$$
	UPDATE FlowDevice set located = located_new, name = name_new
	WHERE idDevice = idDevice_r;
	$$
Language SQL;

--*****Flow Report table*****
--Add flow report
CREATE OR REPLACE FUNCTION addFlowReport(idDevice_r integer) RETURNS integer AS
	$$
	DECLARE
		idReportCreated integer;
	BEGIN
		insert into flowReport(idDevice) values (idDevice_r);
		select MAX(idReport) from flowReport into idReportCreated;
		return idReportCreated;
	END;
	$$
Language plpgsql;

--Get last flow report
CREATE OR REPLACE FUNCTION getLastFlowReport(idDevice_r integer) 
RETURNS TABLE(idReport integer,
			  reportDate TIMESTAMP,
			  idFlow integer,
			  Flow float) AS
	$$
	DECLARE
		idReportConsulted integer;
	BEGIN
		--returns last id from the report table
		select max(fr.idReport) from flowReport as fr into idReportConsulted where idDevice = idDevice_r;
		RETURN QUERY
		select fr.idReport, tv.dateTime, f.idFlow, f.Flow
		from flowReport as fr
		inner join TimeVector as tv on fr.idTime = tv.idTime
		inner join Flow as f on f.idReport = fr.idReport
		where fr.idReport = idReportConsulted;
	END;
	$$
Language plpgsql;

--Get reports by time
CREATE OR REPLACE FUNCTION getFlowReports(idDeviceConsulted integer, fromDate TIMESTAMP, toDate TIMESTAMP) 
RETURNS TABLE(idReport integer,
			  reportDate TIMESTAMP,
			  idFlow integer,
			  Flow float) AS
	$$
	BEGIN		
		RETURN QUERY
		select fr.idReport, tv.dateTime, f.idFlow, f.Flow from flowReport as fr
		inner join TimeVector as tv on fr.idTime = tv.idTime
		inner join Flow as f on f.idReport = fr.idReport
		inner join FlowDevice as fd on fd.idDevice = fr.idDevice
		where fd.idDevice = idDeviceConsulted and (tv.dateTime >= fromDate and tv.dateTime <= toDate)
    	ORDER BY tv.dateTime;
	END;
	$$
Language plpgsql;

--*****Flow table*****
--Add new flow meassure
CREATE OR REPLACE FUNCTION addFlow(idFlow_r integer, idReport_r integer, flow_r float) RETURNS void AS 
	$$
	insert into Flow values (idFlow_r, idReport_r, flow_r);
	$$
Language SQL;


--*****Quality Device table*****
--Add a new Quality device
CREATE OR REPLACE FUNCTION addQualityDevice(idDevice integer, ip varchar, name_r varchar, mac varchar, tolerance float, phoneNumber varchar, idFrequency integer, located varchar) RETURNS void AS 
	$$
	insert into QualityDevice values (idDevice, ip, name_r, mac, tolerance, phoneNumber, idFrequency, located);
	$$
Language SQL;


--Update a Quality Device
CREATE OR REPLACE FUNCTION modifyQualityDevice(idDevice_r integer, ip_new varchar, name_new varchar, mac_new varchar, tolerance_new float,
											   phoneNumber_new varchar, idFrequency_new integer, located_new varchar) RETURNS void AS 
	$$
	UPDATE QualityDevice set ip = ip_new, name = name_new, mac = mac_new, tolerance = tolerance_new, phoneNumber = phoneNumber_new,
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

--Get quality device by id
CREATE OR REPLACE FUNCTION getQualityDevice(idDevice_r integer) RETURNS SETOF QualityDevice AS
	$$
	select * from QualityDevice where idDevice = idDevice_r;
	$$
Language SQL;

--*****Atmospheric Device table*****
--Add a new Atmospheric device
CREATE OR REPLACE FUNCTION addAtmosphericDevice(idDevice integer, ip varchar, name_r varchar, mac varchar, tolerance float, phoneNumber varchar, idFrequency integer, located varchar) RETURNS void AS 
	$$
	insert into atmosphericDevice values (idDevice, ip, name_r, mac, tolerance, phoneNumber, idFrequency, located);
	$$
Language SQL;

--Update a Atmospheric Device
CREATE OR REPLACE FUNCTION modifyAtmosphericDevice(idDevice_r integer, ip_new varchar, name_new varchar, mac_new varchar, tolerance_new float,
											   phoneNumber_new varchar, idFrequency_new integer, located_new varchar) RETURNS void AS 
	$$
	UPDATE AtmosphericDevice set ip = ip_new, name = name_new, mac = mac_new, tolerance = tolerance_new, phoneNumber = phoneNumber_new,
	idFrequency = idFrequency_new, located = located_new
	WHERE idDevice = idDevice_r;
	$$
Language SQL;

--Get the last atmospheric device created according to the highest id
CREATE OR REPLACE FUNCTION getLastAtmosphericDevice() RETURNS AtmosphericDevice AS
	$$
	select * from AtmosphericDevice
	order by idDevice desc;
	$$
Language SQL;

--Get all the atmospheric devices created
CREATE OR REPLACE FUNCTION getAtmosphericDevices() RETURNS SETOF AtmosphericDevice AS
	$$
	select * from AtmosphericDevice
	$$
Language SQL;

--Get atmospheric device by id
CREATE OR REPLACE FUNCTION getAtmosphericDevice(idDevice_r integer) RETURNS SETOF AtmosphericDevice AS
	$$
	select * from AtmosphericDevice where idDevice = idDevice_r;
	$$
Language SQL;

--*****Water Quality Report table*****
--Creates a new report, sets the time with a time vector and returns the id of this report
CREATE OR REPLACE FUNCTION addQualityReport(idDevice_r integer) RETURNS integer AS
	$$
	DECLARE
		idReportCreated integer;
	BEGIN
		insert into waterQuality(idDevice) values (idDevice_r);
		select MAX(idReport) from waterQuality into idReportCreated;
		return idReportCreated;
	END;
	$$
Language plpgsql;

--Return the last water quality report created according to a device ID *********************NO SIRVE PARA MULTIPLES SENSORES
CREATE OR REPLACE FUNCTION getLastQualityReport(idDevice_r integer) 
RETURNS TABLE(idReport integer,
			  reportDate TIMESTAMP,
			  conductivity float,
			  waterlvl float,
			  ph float,
			  salinity float,
			  turbidity float,
			  solids float,
			  temperature float,
			  volume float) AS
	$$
	DECLARE
		idReportConsulted integer;
	BEGIN
		--returns last id from the report table
		select max(wq.idReport) from waterQuality as wq into idReportConsulted where idDevice = idDevice_r;
		
		RETURN QUERY
		select wq.idReport, tv.dateTime, wc.conductivity, wl.waterLevel, wph.ph, ws.salinity, wt.turbidity, wso.solids, wtp.temperature, wv.volume
		from waterQuality as wq
		inner join TimeVector as tv on wq.idTime = tv.idTime
		inner join WQ_conductivity as wc on wq.idReport = wc.idReport
		inner join WQ_waterlvl as wl on wq.idReport = wl.idReport
		inner join WQ_ph as wph on wq.idReport = wph.idReport
		inner join WQ_salinity as ws on wq.idReport = ws.idReport
		inner join WQ_turbidity as wt on wq.idReport = wt.idReport
		inner join WQ_solids as wso on wq.idReport = wso.idReport
		inner join WQ_temperature as wtp on wq.idReport = wtp.idReport
		inner join WQ_volume as wv on wq.idReport = wv.idReport
		where wq.idReport = idReportConsulted;
	END;
	$$
Language plpgsql;

--*****WQ Conductivity table*****
CREATE OR REPLACE FUNCTION addConductivity(idConduct_r integer, idReport_r integer, conductivity_r float) RETURNS void AS
	$$
	insert into WQ_conductivity values (idConduct_r, idReport_r, conductivity_r);
	$$
Language SQL;

--*****WQ PH table*****
CREATE OR REPLACE FUNCTION addPH(idPH_r integer, idReport_r integer, ph_r float) RETURNS void AS
	$$
	insert into WQ_PH values (idPH_r, idReport_r, ph_r);
	$$
Language SQL;

--*****WQ water level table*****
CREATE OR REPLACE FUNCTION addWaterlvl(idWaterlvl_r integer, idReport_r integer, waterlevel_r float) RETURNS void AS
	$$
	insert into WQ_waterlvl values (idWaterlvl_r, idReport_r, waterlevel_r);
	$$
Language SQL;

--*****WQ salinity table*****
CREATE OR REPLACE FUNCTION addSalinity(idSalinity_r integer, idReport_r integer, salinity_r float) RETURNS void AS
	$$
	insert into WQ_salinity values (idSalinity_r, idReport_r, salinity_r);
	$$
Language SQL;

--*****WQ turbidity table*****
CREATE OR REPLACE FUNCTION addTurbidity(idTurbidity_r integer, idReport_r integer, turbidity_r float) RETURNS void AS
	$$
	insert into WQ_turbidity values (idTurbidity_r, idReport_r, turbidity_r);
	$$
Language SQL;

--*****WQ Solids table*****
CREATE OR REPLACE FUNCTION addSolids(idSolids_r integer, idReport_r integer, solid_r float) RETURNS void AS
	$$
	insert into WQ_solids values (idSolids_r, idReport_r, solid_r);
	$$
Language SQL;

--*****WQ temperature table*****
CREATE OR REPLACE FUNCTION addWQTemperature(idTemperature_r integer, idReport_r integer, temperature_r float) RETURNS void AS
	$$
	insert into WQ_temperature values (idTemperature_r, idReport_r, temperature_r);
	$$
Language SQL;

--*****WQ Volume table*****
CREATE OR REPLACE FUNCTION addWQVolume(idVolume_r integer, idReport_r integer, volume_r float) RETURNS void AS
	$$
	insert into WQ_volume values (idVolume_r, idReport_r, volume_r);
	$$
Language SQL;


--*****Atmospheric Report table*****
--Creates a new report, sets the time with a time vector and returns the id of this report
CREATE OR REPLACE FUNCTION addAtmosphericReport(idDevice_r integer) RETURNS integer AS
	$$
	DECLARE
		idReportCreated integer;
	BEGIN
		insert into atmosphericReport(idDevice) values (idDevice_r);
		select MAX(idReport) from atmosphericReport into idReportCreated;
		return idReportCreated;
	END;
	$$
Language plpgsql;

--Returns the values of the last report created
CREATE OR REPLACE FUNCTION getLastAtmosphericReport(idDevice_r integer) 
RETURNS TABLE(idReport integer,
			  reportDate TIMESTAMP,
			  radiation float,
			  volume float,
			  precipitation float,
			  light float,
			  temperature float,
			  humidity float,
			  pressure float,
			  windSpeed float,
			  windDirection float) AS
	$$
	DECLARE
		idReportConsulted integer;
	BEGIN
		--returns last id from the report table
		select max(ar.idReport) from atmosphericReport as ar into idReportConsulted where idDevice = idDevice_r;
		
		RETURN QUERY
		select ar.idReport, tv.dateTime, r.radiation, v.volume, pt.precipitation, l.light, tp.temperature, h.humidity, pr.pressure, ws.windSpeed, wd.windDirection
		from atmosphericReport as ar
		right join TimeVector as tv on ar.idTime = tv.idTime
		right join AR_radiation as r on ar.idReport = r.idReport
		right join AR_volume as v on ar.idReport = v.idReport
		right join AR_precipitation as pt on ar.idReport = pt.idReport
		right join AR_light as l on ar.idReport = l.idReport
		right join AR_temperature as tp on ar.idReport = tp.idReport
		right join AR_humidity as h on ar.idReport = h.idReport
		right join AR_pressure as pr on ar.idReport = pr.idReport
		right join AR_windSpeed as ws on ar.idReport = ws.idReport
		right join AR_windDirection as wd on ar.idReport = wd.idReport
		where ar.idReport = idReportConsulted;
	END;
	$$
Language plpgsql;

--Returns the values of the reports created by a specific device on a time lapse
CREATE OR REPLACE FUNCTION getAtmosphericReports(idDeviceConsulted integer, fromDate TIMESTAMP, toDate TIMESTAMP) 
RETURNS TABLE(idReport integer,
			  reportDate TIMESTAMP,
			  radiation float,
			  volume float,
			  precipitation float,
			  light float,
			  temperature float,
			  humidity float,
			  pressure float,
			  windSpeed float,
			  windDirection float) AS
	$$
	BEGIN		
		RETURN QUERY
		select ar.idReport, tv.dateTime, r.radiation, v.volume, pt.precipitation, l.light, tp.temperature, h.humidity, pr.pressure, ws.windSpeed, wd.windDirection
		from atmosphericDevice as ad
		left join atmosphericReport as ar on ad.idDevice = ar.idDevice
		right join TimeVector as tv on ar.idTime = tv.idTime
		left join AR_radiation as r on ar.idReport = r.idReport
		left join AR_volume as v on ar.idReport = v.idReport
		left join AR_precipitation as pt on ar.idReport = pt.idReport
		left join AR_light as l on ar.idReport = l.idReport
		left join AR_temperature as tp on ar.idReport = tp.idReport
		left join AR_humidity as h on ar.idReport = h.idReport
		left join AR_pressure as pr on ar.idReport = pr.idReport
		left join AR_windSpeed as ws on ar.idReport = ws.idReport
		left join AR_windDirection as wd on ar.idReport = wd.idReport
		where ad.idDevice = idDeviceConsulted and (tv.dateTime >= fromDate and tv.dateTime <= toDate)
    	ORDER BY tv.dateTime;
	END;
	$$
Language plpgsql;

--*****AR Volume table*****
CREATE OR REPLACE FUNCTION addARVolume(idVolume_r integer, idReport_r integer, volume_r float) RETURNS void AS
	$$
	insert into AR_volume values (idVolume_r, idReport_r, volume_r);
	$$
Language SQL;

--*****AR Radiation table*****
CREATE OR REPLACE FUNCTION addRadiation(idRadiation_r integer, idReport_r integer, radiation_r float) RETURNS void AS
	$$
	insert into AR_radiation values (idRadiation_r, idReport_r, radiation_r);
	$$
Language SQL;

--*****AR Precipitation table*****
CREATE OR REPLACE FUNCTION addPrecipitation(idPrecipitation_r integer, idReport_r integer, precipitation_r float) RETURNS void AS
    $$
    insert into AR_precipitation values (idPrecipitation_r, idReport_r, precipitation_r);
    $$
Language SQL;

--*****AR light table*****
CREATE OR REPLACE FUNCTION addLight(idLight_r integer, idReport_r integer, light_r float) RETURNS void AS
	$$
	insert into AR_light values (idLight_r, idReport_r, light_r);
	$$
Language SQL;

--*****AR temperature table*****
CREATE OR REPLACE FUNCTION addARTemperature(idTemperature_r integer, idReport_r integer, temperature_r float) RETURNS void AS
	$$
	insert into AR_temperature values (idTemperature_r, idReport_r, temperature_r);
	$$
Language SQL;

--*****AR humidity table*****
CREATE OR REPLACE FUNCTION addHumidity(idHumidity_r integer, idReport_r integer, humidity_r float) RETURNS void AS
	$$
	insert into AR_humidity values (idHumidity_r, idReport_r, humidity_r);
	$$
Language SQL;

--*****AR pressure table*****
CREATE OR REPLACE FUNCTION addPressure(idPressure_r integer, idReport_r integer, pressure_r float) RETURNS void AS
	$$
	insert into AR_pressure values (idPressure_r, idReport_r, pressure_r);
	$$
Language SQL;

--*****AR wind speed table*****
CREATE OR REPLACE FUNCTION addWindSpeed(idWindSpeed_r integer, idReport_r integer, windSpeed_r float) RETURNS void AS
	$$
	insert into AR_windSpeed values (idWindSpeed_r, idReport_r, windSpeed_r);
	$$
Language SQL;

--*****AR wind direction table*****
CREATE OR REPLACE FUNCTION addWindDirection(idWindDirection_r integer, idReport_r integer, windDirection_r float) RETURNS void AS
	$$
	insert into AR_windDirection values (idWindDirection_r, idReport_r, windDirection_r);
	$$
Language SQL;



