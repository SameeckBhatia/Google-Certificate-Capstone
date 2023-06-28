-- Creating raw table DIVVY
CREATE TABLE DIVVY AS
SELECT * FROM JAN
UNION ALL
SELECT * FROM FEB
UNION ALL
SELECT * FROM MAR
UNION ALL
SELECT * FROM APR
UNION ALL
SELECT * FROM MAY
UNION ALL
SELECT * FROM JUN
UNION ALL
SELECT * FROM JUL
UNION ALL
SELECT * FROM AUG
UNION ALL
SELECT * FROM SEP
UNION ALL
SELECT * FROM OCT
UNION ALL
SELECT * FROM NOV
UNION ALL
SELECT * FROM DEC;

-- Creating cleaned table CLEANED_DIVVY
CREATE TABLE CLEANED_DIVVY AS
SELECT
     *
FROM
     DIVVY
WHERE
     START_STATION_NAME IS NOT NULL
     AND END_STATION_NAME IS NOT NULL;

-- Creating temp table CASUAL_DIVVY
CREATE VIEW CASUAL_DIVVY AS
SELECT
     start_station_name AS start_casual,
     COUNT(MEMBER_CASUAL) AS count_casual
FROM
     (
          SELECT
               *
          FROM
               CLEANED_DIVVY
          WHERE
               MEMBER_CASUAL = "casual"
     )
GROUP BY
     START_CASUAL
ORDER BY
     COUNT_CASUAL DESC;

-- Creating temp table MEMBER_DIVVY
CREATE VIEW MEMBER_DIVVY AS
SELECT
     start_station_name,
     COUNT(MEMBER_CASUAL) AS count_member
FROM
     (
          SELECT
               *
          FROM
               CLEANED_DIVVY
          WHERE
               MEMBER_CASUAL = "member"
     )
GROUP BY
     START_STATION_NAME
ORDER BY
     COUNT_MEMBER DESC;

-- Creating temp table DAY_AVG
CREATE VIEW DAY_AVG AS
SELECT
     day_of_week,
     ROUND(AVG(RIDE_TIME), 2) AS avg_time,
     COUNT(RIDE_ID) AS count_rides
FROM
     (
          SELECT
               RIDE_ID,
               STARTED_AT,
               ENDED_AT,
               (JULIANDAY(ENDED_AT) - JULIANDAY(STARTED_AT)) * 1440 AS RIDE_TIME,
               STRFTIME("%w", ENDED_AT) + 1 AS DAY_OF_WEEK
          FROM
               CLEANED_DIVVY
     )
GROUP BY
     DAY_OF_WEEK;

-- Creating temp table MONTH_COUNT
CREATE VIEW MONTH_COUNT AS
SELECT
     month,
     count_member,
     count_rides - count_member AS count_casual,
     round(
          1.0 * count_member / (count_rides - count_member),
          2
     ) AS member_casual_ratio,
     count_rides AS total
FROM
     (
          SELECT
               STRFTIME("%m", STARTED_AT) AS month_member,
               COUNT(RIDE_ID) AS count_member
          FROM
               CLEANED_DIVVY
          WHERE
               MEMBER_CASUAL = "member"
          GROUP BY
               month_member
     ) AS MEMBER_TABLE
     INNER JOIN (
          SELECT
               STRFTIME("%m", STARTED_AT) AS month,
               COUNT(RIDE_ID) AS count_rides
          FROM
               CLEANED_DIVVY
          GROUP BY
               month
     ) AS MONTH_TABLE ON MONTH_TABLE.month = MEMBER_TABLE.month_member;

-- Creating temp table STATION_COUNT
CREATE VIEW STATION_COUNT AS
SELECT
     start_station_name,
     count_member,
     count_casual,
     round(1.0 * count_casual / count_member, 2) AS casual_member_ratio,
     (COUNT_MEMBER + COUNT_CASUAL) AS total
FROM
     MEMBER_DIVVY
     INNER JOIN CASUAL_DIVVY ON MEMBER_DIVVY.START_STATION_NAME = CASUAL_DIVVY.START_CASUAL
ORDER BY
     total DESC;