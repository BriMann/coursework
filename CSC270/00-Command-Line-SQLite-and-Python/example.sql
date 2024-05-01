SELECT
    lis.name,
    loc.neighbourhood_group,
    loc.neighbourhood
FROM
    locations AS loc
    INNER JOIN listings AS lis On loc.locID = lis.locID
LIMIT
    10;