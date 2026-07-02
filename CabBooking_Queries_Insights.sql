USE Cab_Booking;

-- ==========================================================
-- CAB BOOKING SYSTEM DATA ANALYSIS PROJECT
-- Database: Cab_Booking
-- Description:
-- This project analyzes customer behavior, driver performance,
-- revenue, trip patterns, cancellations, and operational
-- efficiency using SQL queries.
-- ==========================================================


-- ==========================================================
-- CUSTOMER & BOOKING ANALYSIS
-- ==========================================================

-- Q1: Identify customers who have completed the highest number
-- of bookings. This helps identify loyal and frequent customers.

SELECT c.user_id,c.name,COUNT(*) AS total_bookings
FROM Customer c
JOIN Bookings b ON c.user_id=b.user_id
WHERE b.status='Completed'
GROUP BY c.user_id,c.name
ORDER BY total_bookings DESC;


-- ==========================================================
-- CUSTOMER CANCELLATION ANALYSIS
-- ==========================================================

-- Q2: Find customers who have cancelled more than 30% of their
-- total bookings. This helps identify customers with frequent
-- cancellations and possible service issues.

SELECT c.user_id,c.name,
COUNT(CASE WHEN b.status = 'Cancelled' THEN 1 END) AS cancelled_bookings,
COUNT(*) AS total_bookings,
ROUND(COUNT(CASE WHEN b.status = 'Cancelled' THEN 1 END) * 100.0/ COUNT(*),2) AS cancellation_percentage
FROM Customer c
JOIN Bookings b
ON c.user_id = b.user_id
GROUP BY c.user_id, c.name
HAVING ROUND(COUNT(CASE WHEN b.status = 'Cancelled' THEN 1 END) * 100.0/ COUNT(*),2) > 30
ORDER BY cancellation_percentage DESC;


-- ==========================================================
-- BOOKING TREND ANALYSIS
-- ==========================================================

-- Q3: Determine the busiest day of the week based on the
-- total number of bookings.

SELECT DAYNAME(booking_time) AS day_name,
COUNT(*) AS total_bookings
FROM Bookings
GROUP BY DAYNAME(booking_time)
ORDER BY total_bookings DESC;


-- ==========================================================
-- DRIVER PERFORMANCE ANALYSIS
-- ==========================================================

-- Q4: Identify drivers whose ratings are below 3.0.
-- These drivers may require additional training or monitoring.

SELECT
    driver_id,
    name,
    rating
FROM Driver
WHERE rating < 3.0
ORDER BY rating ASC;


-- ==========================================================
-- DRIVER CANCELLATION ANALYSIS
-- ==========================================================

-- Q5: Identify drivers having more than 20% trip cancellation
-- rate to evaluate driver reliability.

SELECT
    d.driver_id,
    d.name,
    COUNT(CASE WHEN b.status = 'Cancelled' THEN 1 END) AS cancelled_trips,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(CASE WHEN b.status = 'Cancelled' THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS cancellation_percentage
FROM Driver d
JOIN Bookings b
ON d.driver_id = b.driver_id
GROUP BY d.driver_id, d.name
HAVING cancellation_percentage > 20
ORDER BY cancellation_percentage DESC;


-- ==========================================================
-- DRIVER RATING ANALYSIS
-- ==========================================================

-- Calculate the average rating received by each driver.

SELECT driver_id,
AVG(rating) AS avg_rating
FROM Bookings
GROUP BY driver_id
HAVING AVG(rating)>1;


-- ==========================================================
-- DRIVER CANCELLATION PERCENTAGE
-- ==========================================================

-- Calculate cancellation percentage for every driver.

SELECT
    driver_id,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled_trips,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_percentage
FROM Bookings
GROUP BY driver_id
ORDER BY cancellation_percentage DESC;


-- ==========================================================
-- DATA PREPARATION
-- ==========================================================

-- Add a new column to store trip distance.

ALTER TABLE Bookings
ADD distance DECIMAL(5,2);


-- ==========================================================
-- UPDATE DISTANCE VALUES FOR ALL BOOKINGS
-- ==========================================================

UPDATE Bookings SET distance = 18.5 WHERE booking_id = 1001;
UPDATE Bookings SET distance = 9.2 WHERE booking_id = 1002;
UPDATE Bookings SET distance = 11.4 WHERE booking_id = 1003;
UPDATE Bookings SET distance = 22.8 WHERE booking_id = 1004;
UPDATE Bookings SET distance = 7.5 WHERE booking_id = 1005;
UPDATE Bookings SET distance = 10.6 WHERE booking_id = 1006;
UPDATE Bookings SET distance = 15.9 WHERE booking_id = 1007;
UPDATE Bookings SET distance = 8.3 WHERE booking_id = 1008;
UPDATE Bookings SET distance = 20.1 WHERE booking_id = 1009;
UPDATE Bookings SET distance = 12.2 WHERE booking_id = 1010;

UPDATE Bookings SET distance = 6.8 WHERE booking_id = 1011;
UPDATE Bookings SET distance = 24.5 WHERE booking_id = 1012;
UPDATE Bookings SET distance = 10.3 WHERE booking_id = 1013;
UPDATE Bookings SET distance = 9.1 WHERE booking_id = 1014;
UPDATE Bookings SET distance = 19.4 WHERE booking_id = 1015;
UPDATE Bookings SET distance = 13.7 WHERE booking_id = 1016;
UPDATE Bookings SET distance = 21.3 WHERE booking_id = 1017;
UPDATE Bookings SET distance = 5.4 WHERE booking_id = 1018;
UPDATE Bookings SET distance = 11.1 WHERE booking_id = 1019;
UPDATE Bookings SET distance = 23.8 WHERE booking_id = 1020;

UPDATE Bookings SET distance = 7.2 WHERE booking_id = 1021;
UPDATE Bookings SET distance = 16.4 WHERE booking_id = 1022;
UPDATE Bookings SET distance = 6.3 WHERE booking_id = 1023;
UPDATE Bookings SET distance = 17.8 WHERE booking_id = 1024;
UPDATE Bookings SET distance = 12.5 WHERE booking_id = 1025;
UPDATE Bookings SET distance = 9.4 WHERE booking_id = 1026;
UPDATE Bookings SET distance = 18.7 WHERE booking_id = 1027;
UPDATE Bookings SET distance = 10.8 WHERE booking_id = 1028;
UPDATE Bookings SET distance = 20.5 WHERE booking_id = 1029;
UPDATE Bookings SET distance = 5.9 WHERE booking_id = 1030;

UPDATE Bookings SET distance = 14.2 WHERE booking_id = 1031;
UPDATE Bookings SET distance = 21.7 WHERE booking_id = 1032;
UPDATE Bookings SET distance = 6.9 WHERE booking_id = 1033;
UPDATE Bookings SET distance = 12.8 WHERE booking_id = 1034;
UPDATE Bookings SET distance = 15.1 WHERE booking_id = 1035;
UPDATE Bookings SET distance = 11.5 WHERE booking_id = 1036;
UPDATE Bookings SET distance = 19.8 WHERE booking_id = 1037;
UPDATE Bookings SET distance = 7.7 WHERE booking_id = 1038;
UPDATE Bookings SET distance = 17.2 WHERE booking_id = 1039;
UPDATE Bookings SET distance = 10.9 WHERE booking_id = 1040;

UPDATE Bookings SET distance = 20.4 WHERE booking_id = 1041;
UPDATE Bookings SET distance = 9.8 WHERE booking_id = 1042;
UPDATE Bookings SET distance = 23.6 WHERE booking_id = 1043;
UPDATE Bookings SET distance = 8.5 WHERE booking_id = 1044;
UPDATE Bookings SET distance = 12.1 WHERE booking_id = 1045;
UPDATE Bookings SET distance = 21.0 WHERE booking_id = 1046;
UPDATE Bookings SET distance = 6.5 WHERE booking_id = 1047;
UPDATE Bookings SET distance = 18.2 WHERE booking_id = 1048;
UPDATE Bookings SET distance = 13.3 WHERE booking_id = 1049;
UPDATE Bookings SET distance = 8.9 WHERE booking_id = 1050;

-- ==========================================================
-- DRIVER DISTANCE ANALYSIS
-- ==========================================================

-- Q6: Identify the Top 5 drivers who have completed the longest
-- trips based on the total distance covered.

SELECT driver_id,
SUM(distance) AS total_distance
FROM Bookings
GROUP BY driver_id
ORDER BY total_distance DESC
LIMIT 5;


-- ==========================================================
-- REVENUE ANALYSIS
-- ==========================================================

-- Q7: Calculate the total revenue generated from successful
-- bookings.

SELECT SUM(amount) AS total_revenue
FROM Payment
WHERE payment_status='Success';


-- ==========================================================
-- ROUTE ANALYSIS
-- ==========================================================

-- Q8: Identify the Top 3 most frequently travelled routes
-- based on pickup and drop locations.

SELECT pickup,
drop_location,
COUNT(*) AS total_trips
FROM Bookings
GROUP BY pickup,drop_location
ORDER BY total_trips DESC
LIMIT 3;


-- ==========================================================
-- DRIVER PERFORMANCE VS EARNINGS
-- ==========================================================

-- Q9: Analyze whether higher-rated drivers complete more trips
-- and generate higher revenue.

SELECT driver_id,
AVG(rating),
SUM(fare)
FROM Bookings
GROUP BY driver_id;


-- ==========================================================
-- LOW RATED DRIVER ANALYSIS
-- ==========================================================

-- Identify drivers whose average rating is below 3.

SELECT driver_id,
AVG(rating) AS avg_rating
FROM Bookings
GROUP BY driver_id
HAVING AVG(rating)<3;


-- ==========================================================
-- DRIVER PERFORMANCE VS EARNINGS (DUPLICATE QUERY)
-- ==========================================================

-- Duplicate query retained intentionally for project reference.

SELECT driver_id,
AVG(rating),
SUM(fare)
FROM Bookings
GROUP BY driver_id;


-- ==========================================================
-- VIEW BOOKINGS DATA
-- ==========================================================

-- Display all booking records.

SELECT *
FROM Bookings;


-- ==========================================================
-- CANCELLATION REASON ANALYSIS
-- ==========================================================

-- Q10: Identify the most common reasons for trip cancellations.

SELECT cancellation_reason,
COUNT(*)
FROM Bookings
GROUP BY cancellation_reason;


-- ==========================================================
-- TRIP CATEGORY REVENUE ANALYSIS
-- ==========================================================

-- Q11: Compare revenue generated from short-distance and
-- long-distance trips.

SELECT
CASE
WHEN distance<5 THEN 'Short Trip'
ELSE 'Long Trip'
END as Trip_Category,
SUM(fare)
FROM Bookings
GROUP BY 1;


-- ==========================================================
-- CAB TYPE REVENUE ANALYSIS
-- ==========================================================

-- Q12: Compare revenue generated by different cab types to
-- identify the most profitable vehicle category.

SELECT cab_type,
SUM(fare)
FROM Bookings
GROUP BY cab_type;


-- ==========================================================
-- CUSTOMER RETENTION ANALYSIS
-- ==========================================================

-- Q13: Identify customers based on their last booking date
-- and booking frequency to analyze customer retention.

SELECT user_id,
MAX(booking_time) AS last_booking,
COUNT(*) AS total_bookings
FROM Bookings
GROUP BY user_id
ORDER BY last_booking;


-- ==========================================================
-- WEEKDAY VS WEEKEND ANALYSIS
-- ==========================================================

-- Q14: Compare booking volume and revenue between weekdays
-- and weekends to identify demand patterns.

SELECT
CASE
WHEN DAYOFWEEK(booking_time) IN (1,7)
THEN 'Weekend'
ELSE 'Weekday'
END AS booking_type,
COUNT(*) AS total_bookings,
SUM(fare) AS revenue
FROM Bookings
GROUP BY booking_type;