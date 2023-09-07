--User
SELECT addUser('Juancho', 'Juan', 'Perez', 'Rodriguez', 'Juancho@gmail.com', '506123456', '123juan8');
SELECT validateUser('Juancho', '123juan8');
SELECT modifyUser('Juancho', 'Juanchito', 'Perez', 'Rodriguez', 'JuanchoPerez@gmail.com', '506123456', '123juan8');

--Device Location
SELECT addDeviceLocation('Cartago', '112.355.4489', '11452.365.458');
SELECT getLocations();

--*******agregar un trigger que modifique las FK de las tablas que usan esta ubicacion
SELECT modifyDeviceLocation('Cartago', 'Cartaguito', '112.355.4489', '11452.365.458');

--Frecuencies
SELECT addFrequency(2, 3.3, 4.5, 6.7);
SELECT addFrequency(1, 2.3, 4.5, 6.7);
SELECT getFrequencies();
SELECT modifyFrequencies(2, 9.8, 7.6, 6.7)

select * from Frecuencies;