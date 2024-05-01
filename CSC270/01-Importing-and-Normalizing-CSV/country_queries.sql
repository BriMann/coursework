--1
SELECT DISTINCT year FROM Alcohol;

--2
SELECT COUNT(DISTINCT CountryName) FROM Country;

--3
SELECT DISTINCT RegionName FROM Region;

--4
SELECT DISTINCT RegionCode, COUNT(CountryName) AS [# of countries] FROM Country
GROUP BY RegionCode
ORDER BY [# of countries];

SELECT RegionCode, CountryName FROM Country
ORDER BY RegionCode;
--5
SELECT CountryCode, year, MAX(TotalPerCapitaHighEstimate) AS [max alcohol] FROM Alcohol
GROUP BY CountryCode, year
ORDER BY [max alcohol] DESC;

--6
SELECT R.RegionName, A.year, MAX(A.TotalPerCapitaAverageEstimate) AS [max alcohol] 
FROM
    Alcohol AS A
    INNER JOIN Country AS C ON A.CountryCode = C.CountryCode
     INNER JOIN Region AS R ON R.RegionCode = C.RegionCode
GROUP BY R.RegionName, A.year
ORDER BY [max alcohol] DESC;

SELECT R.RegionName, A.year, MAX(A.TotalPerCapitaAverageEstimate) AS [max alcohol] 
FROM
    Alcohol AS A
    INNER JOIN Country AS C ON A.CountryCode = C.CountryCode
     INNER JOIN Region AS R ON R.RegionCode = C.RegionCode
WHERE A.year >= '2013'
GROUP BY R.RegionName, A.year
ORDER BY [max alcohol] DESC;

--7
SELECT COUNT(TestMeasurmentID), CountryCode FROM Alcohol
WHERE  Sex = "Both sexes"
GROUP BY CountryCode
HAVING MAX(TotalPerCapitaAverageEstimate) = 0;

