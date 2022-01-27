-- 1: Display the information about all the animals currently housed in a given SPCA location
SELECT animalID, species, arrivalDAte, leaveDate
FROM animal A, organization O, spca_branch S
WHERE A.orgID=O.orgID AND O.orgID=S.orgID AND S.orgID='1';

-- 2: Move an animal FROM one location to another (and update the information accordingly)
UPDATE animal A
    SET A.orgID='3'
    WHERE A.animalID='5';
-- TODO: Update transports table
    
-- 3: Show all the information for all drivers associated with a particular rescue organization.    
SELECT D.firstname,D.lastname, D.emergencyphonenumber, D.licencePlateNumber, D.DriverLicenseNumber
FROM driver D, organization O, rescue_organization R, Volunteers_At V
WHERE D.DriverLicenseNumber=V.DriverLicenseNumber AND V.orgID=O.orgID AND O.orgID=R.orgID AND R.orgID='1';

-- 4: For a particular donor, show:
-- a: which organizations they donated to 
SELECT D.orgID
FROM  Donation D
WHERE D.donatorID='1';

-- b: total amount donated 
SELECT sum(amount)
FROM Donation D 
WHERE D.donatorID='1';

-- 5: Show the total amount donated for 2018 to a selected organization
SELECT sum(amount)
FROM Donation D 
WHERE Year(D.donationDate)='2018' AND D.orgID='3';

-- 6: Allow someone to adopt a pet:
-- a: show the pets available at a selected shelter
SELECT A.animalID, A.species
FROM Animal A, Shelter S 
WHERE A.orgID=S.orgID AND S.orgID='3';

-- b: update the information required for the adoption.  
UPDATE Animal A
    SET A.leaveDate= CURRENT_DATE() AND A.orgID=null
    WHERE A.animalID='4';
    
INSERT INTO Adopter_Payment VALUE ('Steward', '3', '5', '100');

-- 8: Show the animals that went FROM the SPCA directly to a shelter (ie. they did not go through the rescue organization).
SELECT A.animalID, A.species
FROM Animal A, Shelter S
WHERE A.orgID=S.orgID AND A.animalID NOT IN (SELECT RP.animalID
                                             FROM Rescue_Organization_Payment RP);

-- 9: Show how many animals were rescued during 2018 (by any rescue organization).
SELECT Count(T.animalID)
FROM Transports T
WHERE Year(T.transportDate)='2018';
