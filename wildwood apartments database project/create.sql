DROP TABLE IF EXISTS ProblemReport;
DROP TABLE IF EXISTS ComplexAddress;
DROP TABLE IF EXISTS ComplexInformation;
DROP TABLE IF EXISTS TenantLease;
DROP TABLE IF EXISTS Tenant;
DROP TABLE IF EXISTS Expenses;
DROP TABLE IF EXISTS Apartment;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS Lease;
DROP TABLE IF EXISTS Rent;


CREATE TABLE ProblemReport (
  ProblemReportKey INTEGER,
  MaintenanceKey INTEGER,
  problemReportDate TEXT,
  problemShortDescription TEXT,
  problemType TEXT,
  PRIMARY KEY (ProblemReportKey)
  FOREIGN KEY (MaintenanceKey) REFERENCES Maintenance(MaintenanceKey) ON UPDATE CASCADE
);

CREATE TABLE ComplexAddress (
  buildingID INTEGER,
  Street TEXT,
  City TEXT,
  State TEXT,
  zipCode TEXT NOT NULL,
  Country TEXT,
  PRIMARY KEY (buildingID),
  FOREIGN KEY (buildingID) REFERENCES ComplexInformation(buildingID) ON UPDATE CASCADE
);

CREATE TABLE Tenant (
  tenantID INTEGER,
  tenantFirstName TEXT,
  tenantLastName TEXT,
  tenantPhoneNumber TEXT,
  PRIMARY KEY (tenantID)
);

CREATE TABLE TenantLease (
  tenantID INTEGER,
  leaseNumberID INTEGER,
  PRIMARY KEY (tenantID, leaseNumberID),
  FOREIGN KEY (tenantID) REFERENCES Tenant(tenantID)  ON UPDATE CASCADE,
  FOREIGN KEY (leaseNumberID) REFERENCES Lease(leaseNumberID) ON UPDATE CASCADE
);

CREATE TABLE ComplexInformation (
  buildingID INTEGER,
  totalApartments INTEGER,
  PRIMARY KEY (buildingID)
);

CREATE TABLE Expenses (
  expenseKey INTEGER,
  expenseType TEXT,
  date TEXT,
  buildingID INTEGER,
  tenantExpense REAL,
  businessExpense REAL,
  PRIMARY KEY (expenseKey),
  FOREIGN KEY (buildingID) REFERENCES ComplexInformation(buildingID) ON UPDATE CASCADE
);

CREATE TABLE Apartment (
  apartmentKey INTEGER,
  apartmentID INTEGER,
  apartmentSize REAL,
  totalOccupancy INTEGER,
  buildingID INTEGER,
  PRIMARY KEY (apartmentKey),
  FOREIGN KEY (buildingID) REFERENCES ComplexInformation(buildingID) ON UPDATE CASCADE
);

CREATE TABLE Manager (
  managerFirstName TEXT,
  managerLastName TEXT,
  managerID INTEGER,
  buildingID INTEGER,
  stipend REAL,
  PRIMARY KEY (managerID),
  FOREIGN KEY (buildingID) REFERENCES ComplexInformation(buildingID) ON UPDATE CASCADE
);

CREATE TABLE Maintenance (
  apartmentKey INTEGER,
  MaintenanceKey INTEGER,
  resolution TEXT,
  resolutionDate TEXT,
  repairCompany TEXT,
  PRIMARY KEY (MaintenanceKey),
  FOREIGN KEY (apartmentKey) REFERENCES Apartment(apartmentKey) ON UPDATE CASCADE
);

CREATE TABLE Lease  (
  leaseNumberID INTEGER,
  apartmentKey INTEGER,
  startDate TEXT,
  endDate TEXT,
  rentAmount REAL,
  deposit REAL,
  PRIMARY KEY (leaseNumberID),
  FOREIGN KEY (apartmentKey) REFERENCES Apartment(apartmentKey) ON UPDATE CASCADE
);

CREATE TABLE Rent  (
  rentID INTEGER,
  leaseNumberID INTEGER,
  amountPaid REAL,
  paymentDate TEXT,
  lateException TEXT,
  dueDate TEXT,
  PRIMARY KEY (rentID),
  FOREIGN KEY (leaseNumberID) REFERENCES Lease (leaseNumberID) ON UPDATE CASCADE
);

