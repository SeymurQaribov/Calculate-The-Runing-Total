drop table if exists giris2;
drop table if exists cixis2;

create table giris2(
medaxil int,
date1 date);
create table cixis2(
mexaric int,
date2 date);

insert into cixis2 values(0,'2022-10-25')
insert into cixis2 values(23,'2022-10-26')
insert into cixis2 values (43,'2022-10-29')
insert into cixis2 values (3,'2022-10-31')

insert into giris2 values(23,'2022-10-20')
insert into giris2 values(52,'2022-10-25')
insert into giris2 values(0,'2022-10-26')
insert into giris2 values (37,'2022-10-29')
insert into giris2 values (3,'2022-10-31');

declare @ilq_qaliq int 
set @ilq_qaliq = 0;

with cte_cru as (
select 
date1,
medaxil,
mexaric,
((isnull(medaxil,0) - isnull(mexaric,0))+ @ilq_qaliq )  as balance_today,
((isnull(medaxil,0) - isnull(mexaric,0))+ isnull(@ilq_qaliq,0) ) as ilq_qaliq
from giris2 s
full join cixis2 c
on s.date1 =c.date2),cte_cru2 as(
select date1,medaxil,mexaric,
sum(balance_today) over (order by date1) as son_qaliq,
 sum(ilq_qaliq) over (order by  date1) as ilq_qaliq
from cte_cru )
select date1,lag(ilq_qaliq) over (order by date1) as ilq_qaliq,medaxil,mexaric,son_qaliq from cte_cru2 ;