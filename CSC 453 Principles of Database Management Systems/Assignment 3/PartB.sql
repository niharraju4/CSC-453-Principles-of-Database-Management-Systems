/* Delete the tables if they already exist */
drop table Restaurant;
drop table Reviewer;
drop table Rating;

/* Create the schema for our tables */
create table Restaurant(rID int, name varchar2(100), address varchar2(100), cuisine varchar2(100));
create table Reviewer(vID int, name varchar2(100));
create table Rating(rID int, vID int, stars int, ratingDate date);

/* Populate the tables with our data */
insert into Restaurant values(101, 'India House Restaurant', '59 W Grand Ave Chicago, IL 60654', 'Indian');
insert into Restaurant values(102, 'Bombay Wraps', '122 N Wells St Chicago, IL 60606', 'Indian');
insert into Restaurant values(103, 'Rangoli', '2421 W North Ave Chicago, IL 60647', 'Indian');
insert into Restaurant values(104, 'Cumin', '1414 N Milwaukee Ave Chicago, IL 60622', 'Indian');
insert into Restaurant values(105, 'Shanghai Inn', '4723 N Damen Ave Chicago, IL 60625', 'Chinese');
insert into Restaurant values(106, 'MingHin Cuisine', '333 E Benton Pl Chicago, IL 60601', 'Chinese');
insert into Restaurant values(107, 'Shanghai Terrace', '108 E Superior St Chicago, IL 60611', 'Chinese');
insert into Restaurant values(108, 'Jade Court', '626 S Racine Ave Chicago, IL 60607', 'Chinese');

insert into Reviewer values(2001, 'Sarah M.');
insert into Reviewer values(2002, 'Daniel L.');
insert into Reviewer values(2003, 'B. Harris');
insert into Reviewer values(2004, 'P. Suman');
insert into Reviewer values(2005, 'Suikey S.');
insert into Reviewer values(2006, 'Elizabeth T.');
insert into Reviewer values(2007, 'Cameron J.');
insert into Reviewer values(2008, 'Vivek T.');

insert into Rating values( 101, 2001,2, DATE '2011-01-22');
insert into Rating values( 101, 2001,4, DATE '2011-01-27');
insert into Rating values( 106, 2002,4, null);
insert into Rating values( 103, 2003,2, DATE '2011-01-20');
insert into Rating values( 108, 2003,4, DATE '2011-01-12');
insert into Rating values( 108, 2003,2, DATE '2011-01-30');
insert into Rating values( 101, 2004,3, DATE '2011-01-09');
insert into Rating values( 103, 2005,3, DATE '2011-01-27');
insert into Rating values( 104, 2005,2, DATE '2011-01-22');
insert into Rating values( 108, 2005,4, null);
insert into Rating values( 107, 2006,3, DATE '2011-01-15');
insert into Rating values( 106, 2006,5, DATE '2011-01-19');
insert into Rating values( 107, 2007,5, DATE '2011-01-20');


--1. For each restaurant that has at least one rating, find the highest number of stars that a restaurant received. Return the restaurant name and number of stars. Sort by restaurant name.

select re.name, MAX(ra.stars) as "highest_star"
from Rating ra              
inner join Restaurant re    
on ra.rID = re.rID         
group by re.rid, re.name     
order by re.name; 

--2. For each restaurant, return the name and the 'rating spread', that is, the difference between highest and lowest ratings given to that restaurant. Sort by rating spread from highest to lowest, then by restaurant name.

select re.name, MAX(ra.stars) - MIN(ra.stars) as "rating_spread"
from Rating ra             
inner join Restaurant re   
on ra.rID = re.rID         
group by re.name           
order by MAX(ra.stars) - MIN(ra.stars) desc, re.name;

--3. Find the difference between the average rating of Indian restaurants and the average rating of Chinese restaurants. (Make sure to calculate the average rating for each restaurant, then the average of those averages for Indian and Chinese restaurants. Don't just calculate the overall average rating for Indian and Chinese restaurants.) Note: The difference can be negative.

select MAX(Avrg) - MIN(Avrg) as "difference"
from                            
(select AVG(ra.stars) as Avrg   
from Rating ra                 
inner join Restaurant re        
on ra.rID = re.rID              
where re.cuisine = 'Indian'     
union                           
select AVG(ra.stars) as Avrg    
from Rating ra                 
inner join Restaurant re        
on ra.rID = re.rID              
where re.cuisine = 'Chinese');

--4. Are there reviewers who reviewed both Indian and Chinese restaurants? Write a query and answer Yes/No.

select distinct rev.vID, rev.name
from Rating ra                  
inner join Restaurant re        
on ra.rID = re.rID              
inner join Reviewer rev         
on ra.vID = rev.vID            
where re.cuisine = 'Indian'     
and rev.vID in                  -- and get reviewer id in 
(select rev.vID                 -- select column rev.vID 
from Rating ra                  
inner join Restaurant re        
on ra.rID = re.rID              
inner join Reviewer rev         
on ra.vID = rev.vID             
where re.cuisine = 'Chinese');  

