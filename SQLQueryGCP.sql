-- Google Data Analytics Capstone Project
-- Using Q1 2021 data about Cyclistic Bike Share to present interesting trends and statistics
-- Source Divvy Trip Data

-- 1
-- Clean Data to remove rows that have a null value in columns start_station_name and end_station_name
-- We are assuming that since there is either no starting or ending point the bikes were being picked up/dropped of from Maintenance

--SELECT *
--FROM Q12021
--WHERE start_station_name IS NULL OR end_station_name IS NULL

DELETE
FROM Q12021
WHERE start_station_name IS NULL OR end_station_name IS NULL

-- 2
-- Review the start_station_id and end_station_id columns to ensure the name for each distint id match
-- Update start_station_name and end_station_name to be consistent as needed

SELECT distinct start_station_id, start_station_name
FROM Q12021
WHERE start_station_id IS NOT NULL

SELECT distinct end_station_id, end_station_name
FROM Q12021
WHERE end_station_id IS NOT NULL


SELECT start_station_id
FROM GoogleProject.dbo.Q12021
GROUP BY start_station_id
HAVING MIN (start_station_name) <> MAX (start_station_name);

-- Based on the above query we can see that there are only 2 start_station_id where the start_station_names do not match (13074 and 631).

SELECT end_station_id
FROM GoogleProject.dbo.Q12021
GROUP BY end_station_id
HAVING MIN (end_station_name) <> MAX (end_station_name);

-- Based on the above query we can see that there are only 4 end_station_id where the end_station_names do not match (631, KA1504000168, KA1503000055, AND 13074).

-- Use the UPDATE statement to updates the station names to match

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE start_station_id = 13074

UPDATE GoogleProject.dbo.Q12021
SET start_station_name = 'Broadway & Wilson - Truman College Vaccination Site'
WHERE start_station_name = 'Broadway & Wilson Ave'

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE start_station_id = 631

UPDATE GoogleProject.dbo.Q12021
SET start_station_name = 'Malcolm X College Vaccination Site'
WHERE start_station_name = 'Malcolm X College'

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE end_station_id = '631'

UPDATE GoogleProject.dbo.Q12021
SET end_station_name = 'Malcolm X College Vaccination Site'
WHERE end_station_name = 'Malcolm X College'

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE end_station_id = 'KA1504000168'

UPDATE GoogleProject.dbo.Q12021
SET end_station_name = 'Western & 28th - Velasquez Institute Vaccination Site'
WHERE end_station_name = 'Western Ave & 28th St'

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE end_station_id = 'KA1503000055'

UPDATE GoogleProject.dbo.Q12021
SET end_station_name = 'Halsted & 63rd - Kennedy-King Vaccination Site'
WHERE end_station_name = 'Halsted St & 63rd St'

SELECT *
FROM GoogleProject.dbo.Q12021
WHERE end_station_id = '13074'

UPDATE GoogleProject.dbo.Q12021
SET end_station_name = 'Broadway & Wilson - Truman College Vaccination Site'
WHERE end_station_name = 'Broadway & Wilson Ave'


-- 3
-- Combine start_lat and start_lng into new column new_start_lat_lng
-- Combine end_lat and end_lng into new column new_end_lat_lng

ALTER TABLE Q12021 ADD new_start_lat_lng nvarchar(255)

UPDATE Q12021
SET new_start_lat_lng = CONCAT(start_lat, ',' , start_lng)

ALTER TABLE Q12021 ADD new_end_lat_lng nvarchar(255)

UPDATE Q12021
SET new_end_lat_lng = CONCAT(end_lat, ',' , end_lng)

SELECT distinct start_station_id, start_station_name
FROM Q12021
WHERE start_station_id


-- 4
-- Run different variables to prepare for Data Visualization

SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, member_casual, ride_length, day_of_week, new_start_lat_lng, new_end_lat_lng
FROM GoogleProject.dbo.Q12021
ORDER BY 3,4

-- Looking at casual riders vs members for the type of rides

SELECT
	rideable_type, COUNT (*) AS RideTotal
FROM 
	GoogleProject.dbo.Q12021
GROUP BY
	rideable_type
ORDER BY 1


SELECT
	rideable_type, COUNT (*) AS RideTotal,
	member_casual, COUNT (*) AS RiderTypeTotal
FROM 
	GoogleProject.dbo.Q12021
GROUP BY
	rideable_type,
	member_casual
ORDER BY 1


SELECT
	rideable_type, COUNT (*) AS RideTotal,
	member_casual, COUNT (*) AS RiderTypeTotal,
	day_of_week, COUNT (*) AS DailyTotal
FROM 
	GoogleProject.dbo.Q12021
GROUP BY
	rideable_type,
	member_casual,
	day_of_week
ORDER BY 1


SELECT
	start_station_id,
	start_station_name, COUNT (*) AS PopularStart
FROM 
	GoogleProject.dbo.Q12021
GROUP BY
	start_station_id,
	start_station_name
ORDER BY 1


SELECT
	end_station_id,
	end_station_name, COUNT (*) AS PopularEnd
FROM 
	GoogleProject.dbo.Q12021
GROUP BY
	end_station_id,
	end_station_name
ORDER BY 1

