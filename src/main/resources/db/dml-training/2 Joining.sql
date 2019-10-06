-- Natural JOIN
      select *
        from regions
natural join countries;


select *
  from regions
  join countries using (region_id);


-- Equi JOIN
select * 
  from regions r
  join countries c on r.region_id = c.region_id;

Select * from regions r CROSS JOIN countries c
WHERE r.region_id = c.region_id;


    select * 
      from regions r
inner join countries c on r.region_id = c.region_id;


-- Left JOIN
   select * 
     from regions r 
left join countries c on r.region_id = c.region_id;


-- Right JOIN
    select * 
      from regions r 
right join countries c on r.region_id = c.region_id;


-- Full Outer JOIN
    select * 
      from regions r 
full outer join countries c on r.region_id = c.region_id;


-- Cross JOIN
    select * 
      from regions r 
cross join countries c;


-- JOIN with selection
select * 
  from regions r
  join countries c on r.region_id = c.region_id and c.country_id in ('DE','JP');


select * 
  from regions r
  join countries c on r.region_id = c.region_id
 where c.country_id in ('DE','JP');


select r.*
  from regions r
  join countries c on r.region_id = c.region_id
  join locations l on c.country_id = l.country_id
 where c.country_id in ('DE','JP', 'US');















--select * from 

update locations set country_id = null where country_id in ('EG','ZW','NG','KW',
'NL','FR','UK','DK','BE','CH','MX','BR','AR',
'IN','CN','AU','SG');

delete countries where country_id in ('EG','ZW','NG','KW',
'NL','FR','UK','DK','BE','CH','MX','BR','AR',
'IN','CN','AU','SG');

update countries set region_id = null where country_id in ('IL', 'ZM');
commit;
