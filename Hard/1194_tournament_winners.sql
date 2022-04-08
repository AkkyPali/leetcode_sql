-- https://leetcode.com/problems/tournament-winners/


# Write your MySQL query statement below

with fp as (select 
first_player,
sum(first_score) as first_tot
from matches 
group by 1)

,sp as (select 
second_player,
sum(second_score) as second_tot
from matches 
group by 1)

,pl as (select first_player as player,
first_tot + if(second_tot is null, 0, second_tot) as score
from fp left join sp on fp.first_player = sp.second_player

union 

select second_player as player,
second_tot + if(first_tot is null, 0, first_tot) as score
from fp right join sp on fp.first_player = sp.second_player)

,fin as (select group_id, p.player_id as player_id, 
rank() over(partition by group_id order by score DESC, player_id) r
from players p left join pl on p.player_id = pl.player)

select group_id, player_id 
from fin where r = 1
