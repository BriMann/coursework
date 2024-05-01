/*
                            ***MESSAGES***
### Adria:
--I used lease data from the examples in the textbook
--there is no attribute for if a lease is current or not, did we have a fix?
--also dueDate is a repeat value for a rent, it's the same for every entry each month

### Jacinto:
--I reorganized the insert statements to fix the foreign key constraints 
    errors and changed the monetary atributes types to REAL both here and in the Lucidchart diagram (thanks for noticing Adria!)

                           $$$$ IMPORTANT $$$
   If you run inser.sql you will get UNIQUE constraint errors! So, you
   should run create.sql first.
*/

PRAGMA foreign_keys = ON;

--Tenants with tenant ID 11, 22 and 33 are complex managers
INSERT INTO Tenant (tenantID, tenantFirstName, tenantLastName, tenantPhoneNumber)
VALUES 
    (11, 'Passing', 'Toloba', '2082635896'),
    (22, 'Jessica', 'Pitbull', '2082635811'),
    (33, 'Diva', 'Ary', '2082635866'),
    (1, 'Neru', 'Americano', '2082635888'),
    (2, 'Da', 'Beleza', '2082635894'),
    (3, 'Anna', 'Joyce', '2082635874'),
    (4, 'Pai', 'Diesel', '2082635821'),
    (5, 'Big', 'Nelo', '2082635833');

insert into ComplexInformation (buildingID, totalApartments)
values
(1, 5),
(2, 6),
(3, 7);

INSERT INTO Apartment(apartmentKey, apartmentID, apartmentSize, totalOccupancy, buildingID)
VALUES
      (1, 111, 40.25, 3, 1),
      (2, 222, 50.25, 2, 1),
      (3, 333, 30.5, 1, 1),
      (4, 444, 20.5, 2, 1),
      (16, 555, 21.5, 1, 1),
      (5, 123, 30.5, 3, 2),
      (6, 234, 22.55, 1, 2),
      (7, 345, 40.25, 3, 2),
      (8, 456, 30.5, 2, 2),
      (9, 567, 50.25, 1, 2),
      (17, 678, 51.25, 1, 2),
      (10, 109, 20.5, 2, 3),
      (11, 298, 50.25, 2, 3),
      (12, 387, 40.25, 3, 3),
      (13, 476, 30.5, 1, 3),
      (14, 565, 50.25, 3, 3),
      (15, 654, 40.25, 2, 3),
      (18, 743, 41.25, 1, 3);

INSERT INTO Lease (leaseNumberID, apartmentKey, startDate, endDate, rentAmount, deposit)
VALUES
    (1, 1, '05-01-2013', '05-01-2014', 900.0, 1500.0),
    (2, 5, '10-01-2014', '10-07-2014', 900.0, 1500.0),
    (3, 2, '09-01-2015', '09-01-2016', 900.0, 1500.0),
    (4, 6, '02-01-2017', '02-07-2017', 900.0, 1500.0),
    (5, 3, '08-11-2013', '08-11-2014', 900.0, 1500.0),
    (6, 16, '02-01-2017', '02-07-2017', 900.0, 1500.0),
    (7, 17, '02-01-2017', '02-07-2017', 900.0, 1500.0),
    (8, 18, '02-01-2017', '02-07-2017', 900.0, 1500.0);

INSERT INTO TenantLease (tenantID, leaseNumberID)
VALUES
    (1, 5),
    (2, 4),
    (3, 3),
    (4, 2),
    (5, 1),
    (11, 6),
    (22, 7),
    (33, 8);

INSERT INTO Rent (rentID, leaseNumberID, amountPaid, paymentDate, lateException, dueDate)
VALUES
    (1, 1, 900.0, '07-01-2013', NULL, '07-01-2013'),
    (2, 2, 900.0, '10-01-2014', NULL, '10-01-2014'),
    (3, 4, 800.0, '07-01-2013', NULL, '07-01-2013'),
    (4, 5, 900.0, '02-01-2017', NULL, '02-01-2017'),
    (5, 3, 485.0, '08-11-2013', NULL, '08-11-2013'),
    (6, 6, 900.0, '02-01-2017', NULL, '02-01-2017'),
    (7, 7, 900.0, '02-01-2017', NULL, '02-01-2017'),
    (8, 8, 900.0, '02-01-2017', NULL, '02-01-2017');

INSERT INTO Maintenance(apartmentKey, MaintenanceKey, resolution, resolutionDate, repairCompany)
VALUES
      (1, 3, 'Electrician Rewired', '06-07-2013', 'ZapZap electricians'),
      (2, 2, 'Toilet Plumbing Repaired', '08-19-2013', 'Dump your toilet plumbing'),
      (3, 1, 'New Refrigerator', '09-23-2013', 'TeethChatter Coolers');

INSERT INTO ProblemReport(ProblemReportKey, MaintenanceKey, problemReportDate, problemShortDescription, problemType)
VALUES
      (1, 1, '09-19-2013', 'Freezer is warmer then fridge', 'appliances'),
      (2, 2, '08-10-2013', 'Toilet leeks', 'plumbing'),
      (3, 3, '05-31-2013', 'Outlets dont output power', 'electrical');

insert into ComplexAddress (buildingID, Street, City, State, zipCode, Country)
values
(1, '1321 EastLake', 'Seattle', 'WA', '98123', 'USA'),
(2, '3113 York Blvd', 'Boise', 'ID', '89123', 'USA'),
(3, '1221 WestLake', 'San Fransisco', 'CA', '98321', 'USA');

insert into Manager (managerFirstName, managerLastName, managerID, buildingID, stipend)
values
('Passing', 'Toloba', 1, 1, 1500.00),
('Jessica', 'Pitbull', 2, 2, 1500.00),
('Diva', 'Ary', 3, 3, 1500.00);

insert into Expenses (expenseKey, expenseType, date, buildingID, tenantExpense, businessExpense)
values
(1, 'electrical', '07-05-2013', 1, 0.00, 153.06),
(2, 'floor', '07-05-2013', 1, 230.75, 0.00),
(3, 'wages', '07-05-2013', 1, 0.00, 1200.50),
(4, 'utilities', '07-05-2013', 1, 0.00, 140.35),
(5, 'electrical', '07-15-2013', 3, 0.00, 50.45);
