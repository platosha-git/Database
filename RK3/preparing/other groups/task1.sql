﻿--табл 1
DROP TABLE IF EXISTS IOWorkers;
DROP TABLE IF EXISTS Workers;
CREATE TABLE Workers
(
	WorkerID INT NOT NULL PRIMARY KEY,
	FIO VARCHAR(30) NOT NULL,
	Birthday DATE,
	Dept VARCHAR(30)
);

INSERT INTO Workers(WorkerID, FIO, Birthday, Dept) VALUES
	(1, 'Ivanov Ivan Ivanovich', '25-09-1990', 'IT'),
	(2, 'Petrov Petr Petrovich', '12-11-1987', 'Counter'),
	(3, 'Sidorov Sergey Sergeevich', '10-01-1999', 'Counter');


--табл 2
DROP TABLE IF EXISTS IOWorkers;
CREATE TABLE IOWorkers
(
	WorkerID INT REFERENCES Workers(WorkerID) NOT NULL,
	DateIO DATE,
	DayWeek VARCHAR(30),
	TimeIO TIME,
	TypeIO INT
);

INSERT INTO IOWorkers(WorkerID,	DateIO, DayWeek, TimeIO, TypeIO) VALUES
	(1, '10-12-2018', 'Monday', '9:30', 1),
	(2, '10-12-2018', 'Monday', '8:30', 1),
	(3, '10-12-2018', 'Monday', '10:30', 1),
	(3, '10-12-2018', 'Monday', '11:30', 2),
	(3, '10-12-2018', 'Monday', '11:45', 1),
	(1, '10-12-2018', 'Monday', '20:30', 2),
	(2, '10-12-2018', 'Monday', '17:30', 2),
	(3, '10-12-2018', 'Monday', '19:30', 2),
	(3, '14-12-2018', 'Suturday', '8:50', 1),
	(1, '14-12-2018', 'Suturday', '9:00', 1),
	(1, '14-12-2018', 'Suturday', '9:20', 2),
	(1, '14-12-2018', 'Suturday', '9:25', 1),
	(2, '14-12-2018', 'Suturday', '9:05', 1);


SELECT * FROM IOWorkers;


--Функция
DROP FUNCTION IF EXISTS numWorkers;
CREATE FUNCTION numWorkers()
RETURNS bigINT
AS $$
	SELECT COUNT(*)
	FROM (
		SELECT EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM Birthday) AS ageW
		FROM Workers
		WHERE WorkerID IN (
			SELECT WorkerID
			FROM (
				SELECT WorkerID, DateIO, COUNT(*)
				FROM IOWorkers
				WHERE TypeIO = 2
				GROUP BY WorkerID, DateIO
				HAVING COUNT(*) > 1
			) AS tmp1
		)
	) AS tmp2
	WHERE ageW >= 18 AND ageW < 40;	
	
$$ LANGUAGE SQL;

SELECT * FROM numWorkers();