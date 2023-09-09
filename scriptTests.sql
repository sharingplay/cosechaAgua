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
SELECT addARVolume(3,3,20);
--AR radiation
SELECT addRadiation(4,3,52);
--AR precipitation
SELECT addPrecipitation(2,3,12);
--AR light
SELECT addLight(1,3,33);
--AR temperature
SELECT addARTemperature(1,3,32);
--AR humidity
SELECT addHumidity(1,3,14);
--AR pressure
SELECT addPressure(1,3,31.2);
--AR wind speed
SELECT addWindSpeed(1,3,11);
--AR wind direction
SELECT addWindDirection(1,3,12);

