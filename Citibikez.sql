
-- Question 1) Which 2 Stations are Most Used by riders?
-- Here we are calculating no. of departures from start station
-- selecting name of start station & counts of departures from that station
SELECT `start station name`, COUNT(*) as `num_departures`-- aliasing the count as num-departures
FROM citibike
-- Grouping the results by start station name so as to aggregate the counts
GROUP BY `start station name`
-- ordering the groups by no. of departures, in descending order, so that when we filter for top 2 it's easier
ORDER BY `num_departures` DESC
-- finding top 2 from these results
LIMIT 2;
-- Here we're calculating no. of arrivals at end station
SELECT `end station name`,  -- Selecting the name of the end station
       COUNT(*) AS `num_arrivals`  -- we're also counting the number of arrivals at each station
FROM citibike    -- From the citibike table
GROUP BY `end station name`  -- here we're grouping the result by the end station name to aggregate arrival counts
ORDER BY `num_arrivals` DESC  -- Now we're going to put the count of arrivals in order, in descending order, so can find most popular first in the list
LIMIT 3;  -- Limits the results to only the top 2 stations with the most arrivals


-- Question 2)Which month is the busiest time for Citi bike?
SELECT MONTH(starttime) AS month, COUNT(*) AS ride_count -- here we're only extracting the month part from the starttime column, and counting rides
FROM citibike -- from this table
GROUP BY MONTH(starttime) -- grouping results per month to ensure our ride counts are aggregated per month
ORDER BY ride_count DESC -- ordering the result by ride count in descending order so that the month with highest ride count will be listed first
LIMIT 1; -- limiting it to 1 so that it only shows the top entry
-- also finding busiest day of the month
SELECT DAY(starttime) AS day, COUNT(*) AS ride_count -- here we're only extracting the day part from the starttime column, and counting rides
FROM citibike -- from this table
GROUP BY DAY(starttime) -- grouping results per day to ensure our ride counts are aggregated per day
ORDER BY ride_count DESC -- ordering the result by ride count in descending order so that the day with highest ride count will be listed first
LIMIT 1; -- limiting it to 1 so that it only shows the top entry


-- Question 3)What is the average time of ride?
-- I'm assuming the trip duration is given in seconds
SELECT AVG(tripduration)/60 AS average_trip_duration_minutes -- selecting average of trip duration and converting it to minutes
FROM citibike; -- from citibike table


-- Question 4) How many rides had same origin and destination?
-- Counting rides with same start and end station
SELECT COUNT(*) AS same_origin_destination_rides
FROM citibike -- choosing the table
WHERE `start station id` = `end station id`;-- adding a condition to filter rows where start station and end station is the same




