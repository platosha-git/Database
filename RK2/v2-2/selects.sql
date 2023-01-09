﻿--Предикат сравнения
--Магазины с рейтингом выше среднего
SELECT * 
FROM Shops
WHERE Rate > (
	SELECT AVG(Rate)
	FROM Shops
);

/*
--Инструкция SELECT, использующая агрегатные функции в выражениях столбцов
--Препода и количество предметов у него
SELECT TeacherID, COUNT(*) AS cnt
FROM LesTe
GROUP BY TeacherID
ORDER BY TeacherID;

--Количество преподов на каждой кафедре
SELECT Cafedra.CafedraID, CafedraName, CafedraDesc, COUNT(*)
FROM Cafedra JOIN Teacher ON Teacher.CafedraID = Cafedra.CafedraID
GROUP BY Cafedra.CafedraID
ORDER BY CafedraID, CafedraName, CafedraDesc;


--Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT
DROP TABLE IF EXISTS TempLinksTable;

SELECT Lesson.LessonID, Lesson.LessonName, Teacher.TeacherID, Teacher.FIO
INTO TempLinksTable

FROM Lesson JOIN LesTe ON Lesson.LessonID = LesTe.LessonID
	JOIN Teacher ON LesTe.TeacherID = Teacher.TeacherID;

SELECT * FROM TempLinksTable;
*/