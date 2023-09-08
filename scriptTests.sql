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

select * from atmosphericdevice



select * from QualityDevice;