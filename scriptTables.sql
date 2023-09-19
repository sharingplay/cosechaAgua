	CREATE EXTENSION pgcrypto;

--Users table 
create Table Users (
	userName varchar (30) not null,
	name varchar (40) not null,
	firstLastName varchar (20) not null,
	secondLastName varchar (20) not null,
	email varchar (50) not null,
	phoneNumber varchar (20) not null,
	password varchar not null,
	PRIMARY key (userName)
);

create table DeviceLocation(
	located varchar(50) not null,
	latitude varchar(30) not null,
	longitude varchar(30) not null,
	PRIMARY key (located)
);

create table Frequencies(
	idFrequency integer not null,
	meassureFrequency float not null,
	sendFrequency float not null,
	messageFrequency float not null,
	PRIMARY KEY (idFrequency)
);

create table timeVector (
	idTime serial not null,
	dateTime TIMESTAMP not NULL,
	primary key (idTime)
);

-- Quality Device
create table QualityDevice(
	idDevice integer not null,
	ip varchar (30) not null,
	mac varchar (30) not null,
	tolerance float not null,
	phoneNumber varchar (30) not null,
	idFrequency integer not null,
	located varchar (30) not null,
	PRIMARY KEY (idDevice)	
);

create table waterQuality(
	idReport serial not null,
	idDevice int not null,
	idTime int not null,
	PRIMARY KEY (idReport)
);

create table WQ_conductivity(
	idConduct integer not null,
	idReport integer not null,
	conductivity float not null,
	PRIMARY KEY (idConduct,idReport)
);

create table WQ_waterlvl(
	idWaterlvl integer not null,
	idReport integer not null,
	waterLevel float not null,
	PRIMARY KEY (idWaterlvl,idReport)
);

create table WQ_ph(
	idPH integer not null,
	idReport integer not null,
	ph float not null,
	PRIMARY KEY (idPH,idReport)
);

create table WQ_salinity(
	idSalinity integer not null,
	idReport integer not null,
	salinity float not null,
	PRIMARY KEY (idSalinity,idReport)
);

create table WQ_turbidity(
	idTurbidity integer not null,
	idReport integer not null,
	turbidity float not null,
	PRIMARY KEY (idTurbidity,idReport)
);

create table WQ_solids(
	idSolids integer not null,
	idReport integer not null,
	solids float not null,
	PRIMARY KEY (idSolids,idReport)
);

create table WQ_temperature(
	idTemperature integer not null,
	idReport integer not null,
	temperature float not null,
	PRIMARY KEY (idTemperature,idReport)
);

create table WQ_volume(
	idVolume integer not null,
	idReport integer not null,
	volume float not null,
	PRIMARY KEY (idVolume,idReport)
);


-- Atmospheric Device
create table atmosphericDevice(
	idDevice integer not null,
	ip varchar (30) not null,
	mac varchar (30) not null,
	tolerance float not null,
	phoneNumber varchar (30) not null,
	idFrequency integer not null,
	located varchar (30) not null,
	PRIMARY KEY (idDevice)	
);

create table atmosphericReport(
	idReport serial not null,
	idDevice int not null,
	idTime int not null,
	PRIMARY KEY (idReport)
);

create table AR_radiation(
	idRadiation integer not null,
	idReport integer not null,
	radiation float not null,
	PRIMARY KEY (idRadiation,idReport)
);

create table AR_volume(
	idVolume integer not null,
	idReport integer not null,
	volume float not null,
	PRIMARY KEY (idVolume,idReport)
);

create table AR_precipitation(
	idPrecipitation integer not null,
	idReport integer not null,
	precipitation float not null,
	PRIMARY KEY (idPrecipitation,idReport)
);

create table AR_light(
	idLight integer not null,
	idReport integer not null,
	light float not null,
	PRIMARY KEY (idLight,idReport)
);

create table AR_temperature(
	idTemperature integer not null,
	idReport integer not null,
	temperature float not null,
	PRIMARY KEY (idTemperature,idReport)
);

create table AR_humidity(
	idHumidity integer not null,
	idReport integer not null,
	humidity float not null,
	PRIMARY KEY (idHumidity,idReport)
);

create table AR_pressure(
	idPressure integer not null,
	idReport integer not null,
	pressure float not null,
	PRIMARY KEY (idPressure,idReport)
);

create table AR_windSpeed(
	idWindSpeed integer not null,
	idReport integer not null,
	windSpeed float not null,
	PRIMARY KEY (idWindSpeed,idReport)
);

create table AR_windDirection(
	idWindDirection integer not null,
	idReport integer not null,
	windDirection float not null,
	PRIMARY KEY (idWindDirection,idReport)
);


alter table Users 
add constraint unique_email
unique (email);

-- <<<Foreign Keys>>>
--Table constraints atmospheric radiation
alter table AR_radiation
add constraint FK_idReportRadiation
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric volume
alter table AR_volume
add constraint FK_idReportVolume
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric precipitation
alter table AR_precipitation
add constraint FK_idReportprecipitation
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric light
alter table AR_light
add constraint FK_idReportLight
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric temperature
alter table AR_temperature
add constraint FK_idReportTemperature
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric temperature
alter table AR_humidity
add constraint FK_idReporthumidity
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints atmospheric pressure
alter table AR_Pressure
add constraint FK_idReportPressure
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints wind speed
alter table AR_windSpeed
add constraint FK_idReportwindSpeed
foreign key (idReport) references atmosphericReport(idReport);

--Table constraints wind direction
alter table AR_windDirection
add constraint FK_idReportwindDirection
foreign key (idReport) references atmosphericReport(idReport);


--Table constraints Quality Device
alter table QualityDevice 
add constraint FK_idFrequency
foreign key (idFrequency) references Frequencies(idFrequency);

alter table QualityDevice 
add constraint FK_location
foreign key (located) references DeviceLocation(located);

--Table constraints Atmospheric Device
alter table AtmosphericDevice 
add constraint FK_idFrequencyQuality
foreign key (idFrequency) references Frequencies(idFrequency);

alter table AtmosphericDevice 
add constraint FK_locationQuality
foreign key (located) references DeviceLocation(located);

--Table constraints water quality
alter table waterQuality 
add constraint FK_idDevice
foreign key (idDevice) references qualityDevice(idDevice);

alter table waterQuality 
add constraint FK_idTime
foreign key (idTime) references timeVector(idTime);

--Table constraints water conductivity
alter table WQ_conductivity 
add constraint FK_idReportConductivity
foreign key (idReport) references waterQuality(idReport);

--Table constraints water level
alter table WQ_waterlvl
add constraint FK_idReportWaterlvl
foreign key (idReport) references waterQuality(idReport);

--Table constraints water PH
alter table WQ_ph
add constraint FK_idReportPH
foreign key (idReport) references waterQuality(idReport);

--Table constraints water salinity
alter table WQ_salinity
add constraint FK_idReportSalinity
foreign key (idReport) references waterQuality(idReport);

--Table constraints water turbidity
alter table WQ_turbidity
add constraint FK_idReportTurbidity
foreign key (idReport) references waterQuality(idReport);

--Table constraints water solids
alter table WQ_solids
add constraint FK_idReportSolids
foreign key (idReport) references waterQuality(idReport);

--Table constraints water temperature
alter table WQ_temperature
add constraint FK_idReporttemperature
foreign key (idReport) references waterQuality(idReport);

--Table constraints water volume
alter table WQ_volume
add constraint FK_idReportVolume
foreign key (idReport) references waterQuality(idReport);

--Table constraints atmospheric report
alter table atmosphericReport 
add constraint FK_idDeviceAtmRep
foreign key (idDevice) references atmosphericDevice(idDevice);

alter table atmosphericReport 
add constraint FK_idTimeAtmRep
foreign key (idTime) references timeVector(idTime);
