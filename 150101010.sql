
SELECT course_id FROM ScheduledIn
WHERE room_number='2001';









SELECT course_id FROM ScheduledIn
WHERE letter='C';











SELECT division FROM ScheduledIn
WHERE room_number='L2' or room_number='L3';











SELECT course_id, count(room_number) FROM
(
SELECT course_id, room_number
FROM ScheduledIn
GROUP BY course_id, room_number
) as table_1
GROUP BY course_id
HAVING count(room_number)>1;





 


SELECT D.NAME FROM 
(
SELECT department_id, COUNT(room_number) FROM
(SELECT department_id, course_id, room_number FROM ScheduledIn
WHERE room_number='L1' OR room_number='L2' OR room_number='L3' OR room_number='L4') as table_1
GROUP BY department_id) AS table_2, Department as D
WHERE D.department_id=table_2.department_id;
















SELECT D.name FROM
Department as D
left join
(SELECT D.NAME FROM
(SELECT department_id, COUNT(room_number) FROM
(SELECT department_id, room_number FROM ScheduledIn
WHERE room_number='L2' or room_number='L1') as table_1
group by department_id) as table_2, Department as D
where D.department_id=table_2.department_id) AS table_3
on table_3.name=D.name
where table_3.name IS NULL














select name, count(letter) FROM
(
SELECT name, letter FROM
(SELECT A.course_id, A.letter, D.name 
FROM  ScheduledIn as A, Department as D
WHERE D.department_id=A.department_id
GROUP BY A.course_id, A.letter, D.name
) as table_1
group by name ,letter) as table_1
group by name
HAVING count(letter)=17;















select * from 
(select letter, count(course_id) as course_id_number FROM
(select letter, course_id FROM
ScheduledIn) as table_1
group by letter) as table_2
order by course_id_number;













select * from 
(select room_number, count(course_id) as no_courses from
(select course_id, room_number from
ScheduledIn) as table_1
group by room_number) as table_2
order by no_courses DESC
;














select letter from 
(select letter, count(course_id) as course_id_number FROM
(select letter, course_id FROM
ScheduledIn) as table_1
group by letter) as table_2
where course_id_number=
(select min(course_id_number) from
(
select letter, count(course_id) as course_id_number FROM
(select letter, course_id FROM
ScheduledIn) as table_1
group by letter) as table_2
)

















select letter from ScheduledIn 
where course_id regexp 'm$'
group by letter;













select department_id,letter from
(
SELECT table_1.department_id , table_1.letter , table_2.department_id as di2, table_2.letter as li2 FROM 
(
select a.department_id , b.letter
from Department as a , Slot as b
) as table_1
LEFT join
(
select  b.department_id , a.letter 
from ScheduledIn as a , Department as b
where b.department_id=a.department_id
group by a.letter, b.department_id
order by b.department_id ,a.letter
) as table_2
ON table_1.department_id = table_2.department_id and table_1.letter=table_2.letter
WHERE table_2.letter IS NULL
) as table_1
group by department_id, letter
order by department_id;

