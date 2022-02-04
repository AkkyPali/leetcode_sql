-- https://leetcode.com/problems/unpopular-books/
# (Books available in for > 1 month) - (books sold last year and sold > 10 copies)

with sold_cte as (
    select name, sum(quantity) as sold, o.book_id
from orders o left join books b on b.book_id = o.book_id
where abs(datediff(dispatch_date, "2019-06-23")) <= 365
group by book_id
)

select book_id, name
from books
where abs(datediff(available_from,"2019-06-23")) >= 30
and book_id not in(select book_id from sold_cte where sold >= 10)

