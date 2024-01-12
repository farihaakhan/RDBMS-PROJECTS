--varchar
select table_name, column_name, data_type 
from im.information_schema.columns
where  table_schema = 'public' and table_name = 'title_basics';


--Create View and Table

create view im.public.etl_name_basics_v
as
select 
 tb.nconst
,tb."primaryName"
,tb."birthYear"
,tb."deathYear"
,regexp_split_to_array(tb."primaryProfession",',')::varchar[] as primaryprofession       
,regexp_split_to_array(tb."knownForTitles",',')::varchar[] as knownfortitles       
from im.public.name_basics tb;

create table im.public.xf_name_basics
as
select * from im.public.etl_name_basics_v;


create view im.public.etl_title_basics_v
as
select 
 tb.tconst
,tb."titleType"
,tb."primaryTitle"
,tb."originalTitle"
,cast(tb."isAdult" as boolean) as isadult
,cast(tb."startYear" as integer) as startyear
,cast(tb."endYear" as integer) as endyear
,cast(tb."runtimeMinutes" as integer) as runtimeminutes
,regexp_split_to_array(tb.genres,',')::varchar[] as genres       
from im.public.title_basics tb;

create table im.public.xf_title_basics
as
select * from im.public.etl_title_basics_v;


create view im.public.etl_title_crew_v
as
select 
 tb.tconst
,regexp_split_to_array(tb.directors,',')::varchar[] as directors 
,regexp_split_to_array(tb.writers,',')::varchar[] as writers       
from im.public.title_crew tb;

create table im.public.xf_title_crew
as
select * from im.public.etl_title_crew_v;


create view im.public.etl_title_episode_v
as
select 
 tb.tconst
,tb."parentTconst"
,cast(tb."seasonNumber" as integer) as seasonnumber
,cast(tb."episodeNumber" as integer) as episodenumber    
from im.public.title_episode tb;

create table im.public.xf_title_episode
as
select * from im.public.etl_title_episode_v;


create view im.public.etl_title_principals_v
as
select 
 tb.tconst
,tb.nconst
,tb."category"
,tb."job"
,tb."characters"
,cast(tb."ordering" as integer) as ordering
from im.public.title_principals tb;

create table im.public.title_principals
as
select * from im.public.etl_title_principals_v;


create view im.public.etl_title_ratings_v
as
select 
 tb.tconst
,cast(tb."averageRating" as float) as averagerating
,cast(tb."numVotes" as integer) as numvotes
from im.public.title_ratings tb;

create table im.public.xf_title_ratings
as
select * from im.public.etl_title_ratings_v;


--Primary Key
ALTER TABLE im.public.xf_name_basics ADD PRIMARY KEY (nconst);
ALTER TABLE im.public.xf_title_basics ADD PRIMARY KEY ("primaryTitle", "originalTitle");
ALTER TABLE im.public.xf_title_episode ADD PRIMARY KEY ("parentTconst", "seasonNumber");

--Foreign Key
ALTER TABLE im.public.xf_title_basics
ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst);

ALTER TABLE im.public.xf_title_episode
ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst);

ALTER TABLE im.public.xf_title_crew
ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst);

ALTER TABLE im.public.xf_title_principals
ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst),
ADD FOREIGN KEY (ordering) REFERENCES title_akas(ordering),
ADD FOREIGN KEY (nconst) REFERENCES im.public.xf_name_basics(nconst);

ALTER TABLE im.public.xf_title_ratings 
ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst);


--Exercise 2
--1
SELECT count(*) FROM xf_title_basics
WHERE runtimeminutes BETWEEN 42 AND 77;

--2
SELECT AVG(runtimeminutes) as AverageRuntime
FROM xf_title_basics
WHERE isadult = '1';

--3
select count(*) from (
select xtb_a.runtimeminutes, xtb_b.runtimeminutes
from im.public.xf_title_basics xtb_a, im.public.xf_title_basics xtb_b
)x;

--4
select round (AVG (runtimeminutes),0) as roundedAVG
	FROM xf_title_basics
	WHERE genres [1] = 'Action'

--5
select * from (
select genres,  count(*) DistinctGenres 
from xf_title_basics				
group by genres
order by DistinctGenres desc
)g

--6
SELECT genresArray, count(*) as Total_Genres
FROM xf_title_basics xtb, unnest(xtb.genres) as genresArray
GROUP BY genresArray;

--Exercise 3
--1 
SELECT xf_title_basics.tconst, xf_title_crew.tconst
FROM xf_title_basics
FULL OUTER JOIN xf_title_crew ON xf_title_basics.tconst = xf_title_crew.tconst;

--2
SELECT xtb.tconst, xtc.tconst
from xf_title_basics xtb,xf_title_crew xtc  
	(
	select tconst, count(*) as TitleCrewTconst
	from xf_title_crew xtc
	group by xf_title_basics.tcons	
  ) t
