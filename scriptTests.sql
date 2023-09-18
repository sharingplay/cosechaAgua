--User
SELECT addUser('Juancho', 'Juan', 'Perez', 'Rodriguez', 'Juancho@gmail.com', '506123456', '123juan8');
SELECT validateUser('Juancho', '123juan8');
SELECT modifyUser('Juancho', 'Juanchito', 'Perez', 'Rodriguez', 'JuanchoPerez@gmail.com', '506123456', '123juan8');

--Device Location
SELECT addDeviceLocation('Cartago', '112.355.4489', '11452.365.458');
SELECT addDeviceLocation('San Jose', '255.255.255', '213.235.254');
SELECT getLocations();
SELECT modifyDeviceLocation('Cartago', 'Cartago Campeon', '112.355.4489', '11452.365.458');
select * from deviceLocation

--Frecuencies
SELECT addFrequency(2, 3.3, 4.5, 6.7);
SELECT addFrequency(1, 2.3, 4.5, 6.7);
SELECT getFrequencies();
SELECT getFrequency(2);
SELECT modifyFrequencies(2, 10.9, 8.7, 6.5);

--Quality Device
SELECT addQualityDevice(1, '123.412', '456.123', '5.4', '+50699887766', 2, 'Cartago Campeon');
SELECT addQualityDevice(2, '000.123.412', '000.456.123', '6.7', '+506111111', 1, 'Cartago Campeon');
SELECT getLastQualityDevice();
SELECT modifyQualityDevice (2, '987.654','888.777', 1.5, '+50624451234', 1, 'San Jose');
SELECT getQualityDevice(2);
SELECT getQualityDevices();


--Atmospheric Device
SELECT addAtmosphericDevice(1, '255.255.0', '123.456.789', 2.4, '+50688665544', 1, 'San Jose');
SELECT addAtmosphericDevice(2, '255.254.1', '987.456.987', 1.3, '+50688665544', 2, 'Cartago Campeon');
SELECT modifyAtmosphericDevice (2, '654.654','888.777', 1.5, '+50624451234', 1, 'San Jose');
SELECT getLastAtmosphericDevice();
SELECT getAtmosphericDevices();
SELECT getAtmosphericDevice(1);


--Water Quality Report
SELECT addQualityReport(2);
--WQ Conductivity
SELECT addConductivity(2,2,20.5);
--WQ PH
SELECT addPH(5,2,7);
--WQ water level
SELECT addWaterlvl(1,2,10.3);
--WQ salinity
SELECT addsalinity(1,3,7.5);
--WQ turbidity
SELECT addTurbidity(1,3,7.5);
--WQ solids
SELECT addSolids(1,3,7.5);
--WQ temperature
SELECT addWQTemperature(3,3,23);
--WQ volume
SELECT addWQVolume(3,3,20);


--Atmospheric Report
SELECT addAtmosphericReport(1);
--AR volume
SELECT addARVolume(1,5,44);
--AR radiation
SELECT addRadiation(1,5,55);
--AR precipitation
SELECT addPrecipitation(1,5,66.4);
--AR light
SELECT addLight(1,5,33);
--AR temperature
SELECT addARTemperature(1,5,34.5);
--AR humidity
SELECT addHumidity(1,5,75.2);
--AR pressure
SELECT addPressure(1,5,11.2);
--AR wind speed
SELECT addWindSpeed(1,5,10.5);
--AR wind direction
SELECT addWindDirection(1,5,45.1);
--Last report
SELECT * from getLastAtmosphericReport();
--Reports between specific times *************************PROBAR ESTA FUNCION pero corregir antes lo de arreglar multiples sensores
select * from getAtmosphericReports(1, '2023-09-09 01:00:00', '2023-09-17 17:00:00')

select * from atmosphericReport;
select * from AR_radiation;
select * from AR_volume;
select * from AR_light;
select * from AR_precipitation;
select * from AR_temperature;
select * from AR_humidity;
select * from AR_pressure;
select * from AR_windSpeed;
select * from AR_windDirection;
select * from timeVector;

SELECT * from CURRENT_TIMESTAMP;

