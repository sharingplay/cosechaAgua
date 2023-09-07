--User
SELECT addUser('Juancho', 'Juan', 'Perez', 'Rodriguez', 'Juancho@gmail.com', '506123456', '123juan8');
SELECT validateUser('Juancho', '123juan8');
SELECT modifyUser('Juancho', 'Juanchito', 'Perez', 'Rodriguez', 'JuanchoPerez@gmail.com', '506123456', '123juan8');

--Device Location
SELECT addDeviceLocation('Cartago', '112.355.4489', '11452.365.458');
SELECT * from getLocations();

--*******agregar un trigger que modifique las FK de las tablas que usan esta ubicacion
SELECT modifyDeviceLocation('Cartago', 'Cartaguito', '112.355.4489', '11452.365.458');

--Frecuencies
SELECT addFrequency(2, 3.3, 4.5, 6.7);
SELECT addFrequency(1, 2.3, 4.5, 6.7);
SELECT getFrequencies();
--*******agregar un trigger que modifique las FK de las tablas que usan esta frecuencia
SELECT modifyFrequencies(2, 9.8, 7.6, 6.7)

--Quality Device
SELECT addQualityDevice(1, '123.412', '456.123', '5.4', '+50699887766', 2, 'Cartaguito');
SELECT addQualityDevice(2, '000.123.412', '000.456.123', '6.7', '+506111111', 1, 'Cartaguito');
SELECT getLastQualityDevice();
SELECT modifyQualityDevice (2, '987.654','888.777', 1.5, '+50624451234', 1, 'Cartaguito');
SELECT getQualityDevices();


select * from QualityDevice;