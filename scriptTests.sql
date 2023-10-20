--User
SELECT addUser('Juancho', 'Juan', 'Perez', 'Rodriguez', 'Juancho@gmail.com', '506123456', '123juan8');
SELECT validateUser('Juancho', '123juan8');
SELECT modifyUser('Juancho', 'Juanchito', 'Perez', 'Rodriguez', 'JuanchoPerez@gmail.com', '506123456', '123juan8');

--Device Location
SELECT addDeviceLocation('Cartago', '112.355.4489', '11452.365.458');
SELECT addDeviceLocation('San Jose', '255.255.255', '213.235.254');
SELECT getLocations();
SELECT modifyDeviceLocation('Cartago', 'Cartago Campeon', '112.355.4489', '11452.365.458');
select * from deviceLocation;


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
SELECT * from getQualityDevices();
select * from qualityDevice;


--Atmospheric Device
SELECT addAtmosphericDevice(1, '255.255.0', '123.456.789', 2.4, '+50688665544', 1, 'San Jose');
SELECT addAtmosphericDevice(2, '255.254.1', '987.456.987', 1.3, '+50688665544', 2, 'Cartago Campeon');
SELECT modifyAtmosphericDevice (2, '654.654','888.777', 1.5, '+50624451234', 1, 'San Jose');
SELECT * from getLastAtmosphericDevice();
SELECT * from getAtmosphericDevices();
SELECT * from getAtmosphericDevice(1);
select * from atmosphericDevice;

--Flow Device

select addFlowDevice('San Jose', 'nuevo dispositivo de flujo');
select addFlow(1, 2, 12.3);
select * from getFlowDevices();
select * from Flow;



--Water Quality Report
SELECT addQualityReport(1);

--Sensor number, Report ID, Value
--WQ Conductivity
SELECT addConductivity(1,2,2.1);
SELECT addConductivity(2,2,2.2);
SELECT addConductivity(3,2,2.3);
SELECT addConductivity(1,3,3.1);
SELECT addConductivity(2,3,3.2);
SELECT addConductivity(3,3,3.3);
SELECT addConductivity(1,7,7.1);
SELECT addConductivity(2,7,7.2);
SELECT addConductivity(3,7,7.3);

--WQ PH
SELECT addPH(1,2,22.1);
SELECT addPH(2,2,22.2);
SELECT addPH(3,2,22.3);
SELECT addPH(1,3,33.1);
SELECT addPH(2,3,33.2);
SELECT addPH(3,3,33.3);
SELECT addPH(1,7,77.1);
SELECT addPH(2,7,77.2);
SELECT addPH(3,7,77.3);

--WQ water level
SELECT addWaterlvl(1,2,20.1);
SELECT addWaterlvl(2,2,20.2);
SELECT addWaterlvl(3,2,20.3);
SELECT addWaterlvl(1,3,30.1);
SELECT addWaterlvl(2,3,30.2);
SELECT addWaterlvl(3,3,30.3);
SELECT addWaterlvl(1,7,70.1);
SELECT addWaterlvl(2,7,70.2);
SELECT addWaterlvl(3,7,70.3);

--WQ salinity
SELECT addsalinity(1,2,20.10);
SELECT addsalinity(2,2,20.20);
SELECT addsalinity(3,2,20.30);
SELECT addsalinity(1,3,30.10);
SELECT addsalinity(2,3,30.20);
SELECT addsalinity(3,3,30.30);
SELECT addsalinity(1,7,70.10);
SELECT addsalinity(2,7,70.20);
SELECT addsalinity(3,7,70.30);

--WQ turbidity
SELECT addTurbidity(1,2,2.01);
SELECT addTurbidity(2,2,2.02);
SELECT addTurbidity(3,2,2.03);
SELECT addTurbidity(1,3,3.01);
SELECT addTurbidity(2,3,3.02);
SELECT addTurbidity(3,3,3.03);
SELECT addTurbidity(1,7,7.01);
SELECT addTurbidity(2,7,7.02);
SELECT addTurbidity(3,7,7.03);

--WQ solids
SELECT addSolids(1,2,2.001);
SELECT addSolids(2,2,2.002);
SELECT addSolids(3,2,2.003);
SELECT addSolids(1,3,3.001);
SELECT addSolids(2,3,3.002);
SELECT addSolids(3,3,3.003);
SELECT addSolids(1,7,7.001);
SELECT addSolids(2,7,7.002);
SELECT addSolids(3,7,7.003);
--WQ temperature
SELECT addWQTemperature(1,2,20.001);
SELECT addWQTemperature(2,2,20.002);
SELECT addWQTemperature(3,2,20.003);
SELECT addWQTemperature(1,3,30.001);
SELECT addWQTemperature(2,3,30.002);
SELECT addWQTemperature(3,3,30.003);
SELECT addWQTemperature(1,7,70.001);
SELECT addWQTemperature(2,7,70.002);
SELECT addWQTemperature(3,7,70.003);
--WQ volume
SELECT addWQVolume(1,2,22.001);
SELECT addWQVolume(2,2,22.002);
SELECT addWQVolume(3,2,22.003);
SELECT addWQVolume(1,3,33.001);
SELECT addWQVolume(2,3,33.002);
SELECT addWQVolume(3,3,33.003);
SELECT addWQVolume(1,7,77.001);
SELECT addWQVolume(2,7,77.002);
SELECT addWQVolume(3,7,77.003);

select * from waterQuality; --2,3,7
select * from WQ_conductivity;
select * from WQ_ph;
select * from WQ_waterlvl;
select * from WQ_salinity;
select * from WQ_solids;
select * from WQ_turbidity;
select * from WQ_temperature;
select * from WQ_volume;

--Atmospheric Report
SELECT addAtmosphericReport(2);

--Sensor number, Report ID, Value
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
select * from atmosphericReport;
select * from ar_volume;
SELECT * from getLastAtmosphericReport(1);

--Reports between specific times
select * from getAtmosphericReports(1, '2023-09-09 01:00:00', '2023-09-17 17:00:00')

select * from atmosphericReport; -- 3, 5, 7
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
