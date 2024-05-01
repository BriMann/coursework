INSERT INTO Region (RegionName, RegionCode)
SELECT DISTINCT [WHO Region], [WHO Region Code] FROM raw_data;

INSERT INTO Country (RegionCode, CountryName, CountryCode)
SELECT DISTINCT [WHO Region Code], Country, [Country Code] FROM raw_data;

INSERT INTO Alcohol (CountryCode, TotalPerCapitaAverageEstimate, TotalPerCapitaLowEstimate,            TotalPerCapitaHighEstimate, Year, Sex)
SELECT [Country Code], CAST( [Alcohol total per capita (15+) consumption in liters (numeric)] AS REAL),
                      CAST([Alcohol total per capita (15+) consumption in liters (low estimation)] AS REAL),
                      CAST([Alcohol total per capita (15+) consumption in liters (high estimation)] AS REAL),                      Year, Sex FROM  raw_data;