-- https://leetcode.com/problems/friendly-movies-streamed-last-month/

select distinct title
from content c right join tvprogram tp on c.content_id = tp.content_id 
where kids_content = "Y" and content_type = 'movies'
and date_format(program_date,"%m %y") = "06 20"