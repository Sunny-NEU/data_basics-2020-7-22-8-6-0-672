
create table student_stat (
-- TODO:
)

create procedure calc_student_stat()
-- TODO:
delimiter $$
CREATE PROCEDURE calc_student_stat()
BEGIN
CREATE TABLE student_stat as
(
select a.student_id,a.name,b.subject_id,a.subject,a.teacher,a.score,b.sum_score,ROUND(CAST(a.score AS DOUBLE)/b.sum_score,2) rate,c.avg_score
from 
(select t.id student_id,t1.subject_id,SUM(t1.score) sum_score
from student t
left join score t1
  on t.id=t1.student_id
group by t.id,t1.subject_id) b
LEFT JOIN
(select t1.student_id,t.name,t2.subject,t2.teacher,t1.score
from student t
left join score t1
  on t.id=t1.student_id
left join subject t2
  on t1.subject_id=t2.id
ORDER BY student_id) a
on a.student_id=b.student_id
LEFT JOIN
(select t.id,t1.subject_id,avg(t1.score) avg_score
from student t
left join score t1
  on t.id=t1.student_id
group by t.id,t1.subject_id
) c
on a.student_id=c.id
)
;
END$$
delimiter ;
call calc_student_stat();
