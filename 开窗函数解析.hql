

select 
*
from (                     
select numbter,DENSE_RANK() over(order by numbter) rn,max(DENSE_RANK() over(order by numbter)) over(order by numbter) as rn1 from table01
 ) as a
where (rn1%2=0) and ((rn1/2)=rn or rn=((rn1/2)+1)) )  or (rn1%2!=0 and round(rn1/2)=rn)


--取出中间的数据
num   numbter   rn   rn1
10      1       1     1    
10      2       2     2    
10      3       3     3    
10      3       3     4    
10      4       4     5 
10      5       5     6    
10      7       6     7 
10      8       7     8
10      8       7     9
10      9       8     10


select
case when num%2=0  and (num/2+1=rn or num/2=rn) then numbter else null end as nam
case when num%2!=0 and round(num/2)=rn then numbter else null end as nam1
from 
(
select count(1) over() as num,row_number() over(order by numbter) as rn  from table01
) as a
where nam is not null or nam is not null

方法2:把数据正排然后反排再相减取 1 0 -1



numbter    rank     dense_rank  row_number 
  1         1          1            1
  2         2          2            2
  3         3          3            3                                                               
  3         3          3            4
  4         5          4            5
  5         6          5            6
  6         7          6            7
  7         8          7            8
  7         8          7            9
  8         10         8            10
  9         11         9            11


总结:
开窗函数  :rank如果是重复项，总数不变，排序的规则1 2 3 3 5
         :dense_rank如果是重复项，总数变少，排序规则 1 2 3 3 4
         :row_number如果是重复项，总数不变，排序规则 1 2 3 4 5