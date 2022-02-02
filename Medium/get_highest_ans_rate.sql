-- https://leetcode.com/problems/get-highest-answer-rate-question/

with cte as (select question_id, count(question_id) as answer_ct
from surveylog
where action = "answer" and answer_id is not null
group by question_id)

, cte2 as (
select question_id, count(question_id) as show_ct
from surveylog
where action = "show" and answer_id is null
group by question_id)

, cte3 as (select cte2.question_id as survey_log, max(answer_ct/show_ct) over(partition by cte2.question_id) as max
from cte join cte2 on cte.question_id = cte2.question_id
)

select survey_log
from cte3
order by cte3.max DESC,1 ASC 
limit 1