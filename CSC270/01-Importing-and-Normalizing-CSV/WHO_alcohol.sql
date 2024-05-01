DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Alcohol;

CREATE TABLE Region (
  RegionName TEXT,
  RegionCode TEXT,
  PRIMARY KEY (RegionCode)
);

CREATE TABLE Country (
  RegionCode TEXT,
  CountryName TEXT,
  CountryCode TEXT,
  PRIMARY KEY (CountryCode),
  FOREIGN KEY (RegionCode) REFERENCES Region (RegionCode)
);

CREATE TABLE Alcohol (
   TestMeasurmentID INTEGER NOT NULL,
   CountryCode TEXT,
   TotalPerCapitaAverageEstimate REAL,
   TotalPerCapitaLowEstimate REAL,
   TotalPerCapitaHighEstimate REAL,
   Year TEXT,
   Sex TEXT,
  PRIMARY KEY (TestMeasurmentID),
  FOREIGN KEY (CountryCode) REFERENCES Country (CountryCode)
);

