# Create database

DROP DATABASE IF EXISTS Animal_Rescue;
CREATE DATABASE Animal_Rescue;
USE Animal_Rescue;

# Strong entities and specialization

CREATE TABLE Driver (
    firstName               varchar(20),
    lastName                varchar(20),
    emergencyPhoneNumber    char(10) NOT NULL,    
    licencePlateNumber      char(10) NOT NULL,
    driverLicenseNumber     bigint NOT NULL,

    PRIMARY KEY (driverLicenseNumber)
);

CREATE TABLE Donator (
    donatorID   int NOT NULL,
    firstName   varchar(20),
    lastName    varchar(20),

    PRIMARY KEY (donatorID)
);

CREATE TABLE Adopter (
    lastName        varchar(20) NOT NULL,
    phoneNumber     char(10),
    province        varchar(20),
    city            varchar(20),
    street          varchar(30),
    streetNumber    int,

    PRIMARY KEY (lastName)    
);

CREATE TABLE Organization (
    orgID           int NOT NULL,
    orgName         varchar(20),
    province        varchar(20),
    city            varchar(20),
    street          varchar(30),
    streetNumber    int,
    phoneNumber     char(10),

    PRIMARY KEY (orgID)
);

CREATE TABLE Employee (
    employeeID      int NOT NULL,
    orgID           int NOT NULL,
    firstName       varchar(20),
    lastName        varchar(20),
    phoneNumber     char(10),
    province        varchar(20),
    city            varchar(20),
    street          varchar(30),
    streetNumber    int,

    PRIMARY KEY (employeeID),
    FOREIGN KEY (orgID) REFERENCES Organization(orgID)
);

CREATE TABLE SPCA_Branch (
    orgID       int NOT NULL,

    FOREIGN KEY (orgID) REFERENCES Organization(orgID)
);

CREATE TABLE Rescue_Organization (
    orgID       int NOT NULL,
    ownerID     int NOT NULL,

    FOREIGN KEY (orgID) REFERENCES Organization(orgID),
    FOREIGN KEY (ownerID) REFERENCES Employee(employeeID)
);

CREATE TABLE Shelter (
    orgID           int NOT NULL,
    ownerID         int NOT NULL,
    websiteURL      varchar(100),

    FOREIGN KEY (orgID) REFERENCES Organization(orgID),
    FOREIGN KEY (ownerID) REFERENCES Employee(employeeID)
);

CREATE TABLE Animal (
    animalID        int NOT NULL,
    species         enum('cat', 'dog', 'bunny', 'rodent') NOT NULL,
    orgID           int,
    arrivalDate     date,
    leaveDate       date,

    PRIMARY KEY (animalID),
    FOREIGN KEY (orgID) REFERENCES Organization(orgID)
);

# Weak Entities

CREATE TABLE Vet_Visit_Statistics (
    animalID            int NOT NULL,
    vetName             varchar(20) NOT NULL,
    animalCondition     varchar(50),
    animalWeight        decimal(5, 2),
    visitDate           date NOT NULL,

    PRIMARY KEY (animalID, vetName, visitDate),
    FOREIGN KEY (animalID) REFERENCES Animal (animalID)
);

# Many to many relationships

CREATE TABLE Transports (
    sourceID                int NOT NULL,
    destinationID           int NOT NULL,
    animalID                int NOT NULL,
    driverLicenseNumber     bigint NOT NULL,
    transportDate           date NOT NULL,

    PRIMARY KEY (sourceID, destinationID, animalID, driverLicenseNumber),
    FOREIGN KEY (sourceID) REFERENCES Organization(orgID),
    FOREIGN KEY (destinationID) REFERENCES Organization(orgID),
    FOREIGN KEY (animalID) REFERENCES Animal(animalID),
    FOREIGN KEY (driverLicenseNumber) REFERENCES Driver(driverLicenseNumber)
);

CREATE TABLE Donation (
    donatorID       int NOT NULL,
    orgID           int NOT NULL,
    donationDate    date NOT NULL,
    amount          int NOT NULL,
    purpose         varchar(100),

    PRIMARY KEY (donatorID, orgID),
    FOREIGN KEY (donatorID) REFERENCES Donator(donatorID),
    FOREIGN KEY (orgID) REFERENCES Organization(orgID)
);

CREATE TABLE Adopter_Payment (
    lastName        varchar(20) NOT NULL,
    orgID           int NOT NULL,
    animalID        int NOT NULL,
    amountPaid      int NOT NULL,

    PRIMARY KEY(lastName, orgID, animalID),
    FOREIGN KEY(lastName) REFERENCES Adopter(lastName),
    FOREIGN KEY(orgID) REFERENCES Organization(orgID),
    FOREIGN KEY(animalID) REFERENCES Animal(animalID)
);

CREATE TABLE Rescue_Organization_Payment (
    rescurerID      int NOT NULL,
    branchID        int NOT NULL,
    animalID        int NOT NULL,
    amountPaid      int NOT NULL,

    PRIMARY KEY(rescurerID, branchID, animalID),
    FOREIGN KEY(branchID) REFERENCES SPCA_Branch(orgID),
    FOREIGN KEY(animalID) REFERENCES Animal(animalID),
    FOREIGN KEY(rescurerID) REFERENCES Rescue_Organization(orgID)
);

CREATE TABLE Volunteers_At (
    orgID                   int NOT NULL,
    driverLicenseNumber     bigint NOT NULL,

    PRIMARY KEY(orgID, driverLicenseNumber),
    FOREIGN KEY(orgID) REFERENCES Rescue_Organization(orgID),
    FOREIGN KEY(driverLicenseNumber) REFERENCES Driver(driverLicenseNumber)
);

CREATE TABLE Max_Animal_Num (
    shelterID   int NOT NULL,
    species     enum('cat', 'dog', 'bunny', 'rodent') NOT NULL,
    maxNum      int NOT NULL,
    
    PRIMARY KEY(shelterID, species, maxNum),
    FOREIGN KEY(shelterID) REFERENCES Shelter(orgID)
);

# Data

INSERT INTO Organization VALUES 
('1', 'SPCA Of London', 'Ontario', 'London', 'Low St.', '3521', '6135550829'),
('2', 'The Cat Rescuers', 'Ontario', 'London', 'Small St.', '35', '6135551452'),
('3', 'The Cat Shelter', 'Ontario', 'London', 'Loway St.', '235', '6135559582'),
('4', 'SPCA Of Kingston', 'Ontario', 'Kingston', 'Queen Elizabeth blvd.', '566', '6135551112'),
('5', 'Kingston Pet Rescue', 'Ontario', 'Kingston', 'Long Ave.', '989', '6135559096'),
('6', 'Upper Canada Pet Shelter', 'Ontario', 'Kingston', 'King St.', '333', '6135554512');

INSERT INTO Employee VALUES 
('1', '1', 'James', 'Mason', '6135557458', 'Ontario', 'London', 'Main St.', '273'),
('2', '2', 'Jack', 'Smith', '6135552385', 'Ontario', 'London', 'Big St.', '2356'),
('3', '3', 'Mike', 'Told', '6135557271', 'Ontario', 'Toronto', 'Old St.', '721'),
('4', '3', 'Larry', 'Sanders', '6135559180', 'Ontario', 'Kingston', 'Queen St.', '5'),
('5', '2', 'Jose', 'Kavanagh', '6135558921', 'Ontario', 'Ottawa', 'Pinnickinnick St.', '3614'),
('6', '1', 'Joanne', 'Reynolds', '6135555893', 'Ontario', 'Saylorsburg', 'Conference Center Way', '30'),
('7', '4', 'Cailan', 'O\'Connor', '6135557789', 'Ontario', 'Kingston', 'Thor St.', '25'),
('8', '5', 'Jorge', 'Da Silva', '6135553135', 'Ontario', 'Kingston', 'Brock St.', '777'),
('9', '6', 'Jenn', 'Muller', '6135555080', 'Ontario', 'Napanee', 'May St.', '300');

INSERT INTO SPCA_Branch VALUES 
('1'),
('4');

INSERT INTO Rescue_Organization VALUES 
('2', '2'),
('5', '8');

INSERT INTO Shelter VALUES 
('3', '3', 'www.thecatshelter.net'),
('6', '9', 'www.ucpshelter.net');

INSERT INTO Animal VALUES
('1', 'cat', '1', '2020-02-02', '0000-00-00'),
('2', 'dog', '2', '2020-02-01', '0000-00-00'),
('3', 'bunny', '3', '2020-01-12', '2020-03-13'),
('4', 'rodent', '3', '2020-03-02', '2020-03-10'),
('5', 'cat', '2', '2020-01-22', '0000-00-00'),
('6', 'dog', '1', '2020-01-02', '0000-00-00'),
('7', 'dog', '4', '2020-03-22', '0000-00-00'),
('8', 'cat', '5', '2020-02-06', '0000-00-00'),
('9', 'rodent', '6', '2019-09-30', '0000-00-00'),
('10', 'bunny', '5', '2019-11-11', '0000-00-00');

INSERT INTO Driver VALUES
('Raymond', 'Christoph', '4194206969', 'AY3R-4Z1', '324889015554333'),
('Jacob', 'Clement', '4165553678', '5BIN-O8A', '112959056632176'),
('Yuan', 'Xi', '6135553378', 'Y1M7-D3T', '342840224573843');


INSERT INTO Donator VALUES
('1', 'Christine', 'Li'),
('2', 'Abdullah', 'Hussein'),
('3', 'Bill', 'Gates'),
('4', 'Riley', 'Finch');

INSERT INTO Adopter VALUES
('Szymankowszczyzna', '7055555345', 'Ontario', 'Sudbury', 'John St.', '333'),
('Messi', '2895551987', 'Ontario', 'Markham', 'Barcelona St.', '777'),
('Steward', '7055552818', 'Ontario', 'Sudbury', 'Mary St.', '555');

INSERT INTO Transports VALUES
('1', '2', '1', '324889015554333', '2020-03-04'),
('1', '3', '2', '324889015554333', '2020-03-07'),
('2', '3', '1', '112959056632176', '2020-03-08'),
('1', '3', '3', '112959056632176', '2020-03-12'),
('4', '5', '10', '342840224573843', '2020-02-11');

INSERT INTO Donation VALUES
('1', '2', '2020-02-04', '50', 'I like cats'),
('2', '3', '2020-03-01', '150', 'I really like cats'),
('3', '4', '2019-03-02', '1000', 'I <3 dogs'),
('2', '4', '2018-07-02', '200', 'I <3 cats'),
('4', '4', '2018-07-16', '500', 'Help the community'),
('3', '1', '2018-09-12', '10000', 'Pocket Change'),
('4', '5', '2016-04-25', '20', 'Doing what I can'),
('4', '6', '2020-03-14', '50', 'Save animals');

INSERT INTO Adopter_Payment VALUES
('Messi', '1', '4', '30'),
('Szymankowszczyzna', '3', '3', '150');

INSERT INTO Rescue_Organization_Payment VALUES
('2', '1', '1', '100'),
('5', '4', '10', '150');

INSERT INTO Volunteers_At VALUES
('2', '324889015554333'),
('2', '112959056632176'),
('5', '342840224573843');

INSERT INTO Max_Animal_Num VALUES
('3', 'cat', '30');

INSERT INTO Vet_Visit_Statistics VALUES
('9','Rue Joyce','Diabetes','0.50','2019-09-31');