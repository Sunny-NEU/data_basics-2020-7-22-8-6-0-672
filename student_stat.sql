
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
select a.name,a.subject,a.teacher,a.score,b.total_score,concat(TRUNCATE((a.score AS DOUBLE)/b.total_score,2),'%') score_rate,c.avg_score
  from 
      (select t.id student_id,t1.subject_id,SUM(t1.score) total_score
         from student t
         left join score t1
           on t.id=t1.student_id
        group by t.id,t1.subject_id) b
 left join
         (select t1.student_id,t.name,t2.subject,t2.teacher,t1.score
            from student t
            left join score t1
              on t.id=t1.student_id
            left join subject t2
              on t1.subject_id=t2.id
           ORDER BY student_id) a
   on a.student_id=b.student_id
 left join
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
