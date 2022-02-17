-- https://leetcode.com/problems/shortest-distance-in-a-plane/

select round(min(sqrt(pow((p.x - p1.x),2) + pow((p.y - p1.y),2))),2) as shortest
from point2D p , point2D p1 
where p.x != p1.x or p.y != p1.y