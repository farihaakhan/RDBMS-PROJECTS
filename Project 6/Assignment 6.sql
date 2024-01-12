-- CREATE TABLE
create table "IMDB".public.title_akas (
"titleId" varchar,
"ordering" varchar,
"title" varchar,
"region" varchar,
"language" varchar,
"types" varchar,
"attributes" varchar,
"isOriginalTitle" varchar
);

create table "IMDB".public.title_basics (
"tconst" varchar,
"titleType" varchar,
"primaryTitle" varchar,
"originalTitle" varchar,
"isAdult" varchar,
"startYear" varchar,
"endYear" varchar,
"runtimeMinutes" varchar,
"genres" varchar
);

create table "IMDB".public.title_crew(
"tconst" varchar,
"directors" varchar,
"writers" varchar
);

create table "IMDB".public.title_episode(
"tconst" varchar,
"parentTconst" varchar,
"seasonNumber" varchar,
"episodeNumber" varchar
);

create table "IMDB".public.title_principals(
"tconst" varchar,
"ordering" varchar,
"nconst" varchar,
"category" varchar,
"job" varchar,
"characters" varchar
);

create table "IMDB".public.title_ratings(
"tconst" varchar,
"averageRating" varchar,
"numVotes" varchar
);

create table "IMDB".public.name_basics(
"nconst" varchar,
"primaryName" varchar,
"birthYear" varchar,
"deathYear" varchar,
"primaryProfession" varchar, 
"knownForTitles" varchar
);

select count(distinct "titleId") from "IMDB".public.title_akas


--COPY COMMAND
  copy  im.public.name_basics from 'C:\sampledb\name.basics.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_akas from 'C:\sampledb\title.akas.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_basics from 'C:\sampledb\title.basics.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_crew from 'C:\sampledb\title.crew.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_episode from 'C:\sampledb\title.episode.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_principals from 'C:\sampledb\title.principals.tsv\data.tsv' delimiter E'\t';
  copy  im.public.title_ratings from 'C:\sampledb\title.ratings.tsv\data.tsv' delimiter E'\t';


-- SELECT STATEMENT
SELECT * FROM name_basics
LIMIT 100;
SELECT * FROM title_akas
LIMIT 100;
SELECT * FROM title_basics
LIMIT 100;
SELECT * FROM title_crew
LIMIT 100;
SELECT * FROM title_episode
LIMIT 100;
SELECT * FROM title_principals
LIMIT 100;
SELECT * FROM title_ratings
LIMIT 100;


--SELECT STATEMENT TO CHECK THE REPEATING COLUMN NAMES
select * 
from name_basics
where "nconst"  = 'nconst'  
limit 100;

select * 
from title_akas
where "titleId"  = 'titleId'  
limit 100;

select * 
from title_basics
where "nconst"  = 'nconst'  
limit 100;

select * 
from title_crew
where "tconst"  = 'tconst'  
limit 100;

select * 
from title_episode
where "tconst"  = 'tconst'  
limit 100;

select * 
from title_principals
where "tconst"  = 'tconst'  
limit 100;

select * 
from title_ratings
where "tconst"  = 'tconst'  
limit 100;


--DELETE
DELETE
from name_basics
where "tconst"  = 'tconst';

DELETE
from title_akas
where "titleId"  = 'titleId';

DELETE
from title_basics
where "tconst"  = 'tconst';

DELETE
from title_crew
where "tconst"  = 'tconst';

DELETE
from title_episode
where "tconst"  = 'tconst';

DELETE
from title_principals
where "tconst"  = 'tconst';

DELETE
from title_ratings
where "tconst"  = 'tconst';


--COPY TO 
COPY title_akas("titleId", ordering, title, region, language, types, attributes, "isOriginalTitle") 
TO 'C:\sampledb\title.akas.tsv\title_akas.csv' DELIMITER ',' CSV HEADER;
COPY name_basics("nconst", "primaryName", "birthYear", "deathYear", "primaryProfession", "knownForTitles") 
TO 'C:\sampledb\name.basics.tsv\name_basics.csv' DELIMITER ',' CSV HEADER;
COPY title_basics("tconst", "titleType", "primaryTitle", "originalTitle", "isAdult", "startYear","endYear","runtimeMinutes","genres") 
TO 'C:\sampledb\title.basics.tsv\title_basics.csv' DELIMITER ',' CSV HEADER;
COPY title_crew("tconst", "directors", "writers") 
TO 'C:\sampledb\title.crew.tsv\title_crew.csv' DELIMITER ',' CSV HEADER;
COPY title_episode("tconst", "parentTconst", "seasonNumber", "episodeNumber") 
TO 'C:\sampledb\title.episode.tsv\title_episode.csv' DELIMITER ',' CSV HEADER;
COPY title_principals("tconst", "ordering", "nconst", "category",job,characters) 
TO 'C:\sampledb\title.principals.tsv\title_principals.csv' DELIMITER ',' CSV HEADER;
COPY title_ratings("tconst", "averageRating", "numVotes") 
TO 'C:\sampledb\title.ratings.tsv\title_ratings.csv' DELIMITER ',' CSV HEADER;



-- Cardinality
select 'distinct nconst' as NameInfo, count(distinct "nconst") from "name_basics"
union
select 'distinct primaryName'as NameInfo, count(distinct "primaryName") from "name_basics"
union
select 'distinct birthYear' as NameInfo, count(distinct "birthYear") from "name_basics"
union
select 'distinct deathYear'as NameInfo, count(distinct "deathYear") from "name_basics"
union
select 'distinct primaryProfession' as NameInfo, count(distinct "primaryProfession") from "name_basics"
union
select 'distinct knownForTitles'as NameInfo, count(distinct "knownForTitles") from "name_basics"


select 'distinct titleId' as TitleInfo, count(distinct "titleId") from "title_akas"
union
select 'distinct ordering'as TitleInfo, count(distinct "ordering") from "title_akas"
union
select 'distinct title' as TitleInfo, count(distinct "title") from "title_akas"
union
select 'distinct region'as TitleInfo, count(distinct "region") from "title_akas"
union
select 'distinct language' as TitleInfo, count(distinct "language") from "title_akas"
union
select 'distinct types'as TitleInfo, count(distinct "types") from "title_akas"
union
select 'distinct attributes' as TitleInfo, count(distinct "attributes") from "title_akas"
union
select 'distinct isOriginalTitle'as TitleInfo, count(distinct "isOriginalTitle") from "title_akas"


select 'distinct tconst' as TitleBaiscs, count(distinct "tconst") from "title_basics"
union
select 'distinct titleType'as TitleBaiscs, count(distinct "titleType") from "title_basics"
union
select 'distinct primaryTitle' as TitleBaiscs, count(distinct "primaryTitle") from "title_basics"
union
select 'distinct originalTitle'as TitleBaiscs, count(distinct "originalTitle") from "title_basics"
union
select 'distinct isAdult' as TitleBaiscs, count(distinct "isAdult") from "title_basics"
union
select 'distinct startYear'as TitleBaiscs, count(distinct "startYear") from "title_basics"
union
select 'distinct endYear' as TitleBaiscs, count(distinct "endYear") from "title_basics"
union
select 'distinct runtimeMinutes'as TitleBaiscs, count(distinct "runtimeMinutes") from "title_basics"
union 
select 'distinct genres'as TitleBaiscs, count(distinct "genres") from "title_basics"


select 'distinct tconst' as TitleCrewInfo, count(distinct "tconst") from "title_crew"
union
select 'distinct directors'as TitleCrewInfo, count(distinct "directors") from "title_crew"
union
select 'distinct writers' as TitleCrewInfo, count(distinct "writers") from "title_crew"


select 'distinct tconst' as TitleEpisodeInfo, count(distinct "tconst") from "title_episode"
union
select 'distinct parentTconst'as TitleEpisodeInfo, count(distinct "parentTconst") from "title_episode"
union
select 'distinct seasonNumber' as TitleEpisodeInfo, count(distinct "seasonNumber") from "title_episode"
union
select 'distinct episodeNumber'as TitleEpisodeInfo, count(distinct "episodeNumber") from "title_episode"


select 'distinct tconst' as TitlePrinciples, count(distinct "tconst") from "title_principals"
union
select 'distinct ordering'as TitlePrinciples, count(distinct "ordering") from "title_principals"
union
select 'distinct nconst' as TitlePrinciples, count(distinct "nconst") from "title_principals"
union
select 'distinct category'as TitlePrinciples, count(distinct "category") from "title_principals"
union
select 'distinct job' as TitlePrinciples, count(distinct "job") from "title_principals"
union
select 'distinct characters'as TitlePrinciples, count(distinct "characters") from "title_principals"


select 'distinct tconst' as TitleRating, count(distinct "tconst") from "title_ratings"
union
select 'distinct averageRating'as TitleRating, count(distinct "averageRating") from "title_ratings"
union
select 'distinct numVotes' as TitleRating, count(distinct "numVotes") from "title_ratings"


-- ALTER TABLE TO ADD PRIMARY KEY
ALTER TABLE im.public.title_akas ADD PRIMARY KEY ("titleId", ordering);
ALTER TABLE im.public.name_basics ADD PRIMARY KEY (nconst);
ALTER TABLE im.public.title_basics ADD PRIMARY KEY ("primaryTitle", "originalTitle");
ALTER TABLE im.public.title_episode ADD PRIMARY KEY ("parentTconst");

--ALTER TABLE im.public.title_principals ADD PRIMARY KEY ("tconst", "ordering","nconst");
--ALTER TABLE im.public.title_crew ADD PRIMARY KEY ("tconst", "directors","writers");
--ALTER TABLE im.public.title_ratings ADD PRIMARY KEY ("tconst");


--EXCEPT COUNT
select count(*)
from 
  (select (tconst)
  from im.public.title_ratings
  EXCEPT
  select (tconst)
  from im.public.title_basics
  ) p

-- EXCEPT COLUMNS
select *
from 
	(select (tconst)
	 from im.public.title_ratings
	 EXCEPT
	 select (tconst)
	 from im.public.title_basics
	 ) p

-- INTERSECT
select count(*)
from 
	(select (tconst)
	 from im.public.title_ratings
	 INTERSECT
	 select (tconst)
	 from im.public.title_basics
	 ) p

-- FOREIGN KEY
ALTER TABLE title_ratings
  ADD FOREIGN KEY (tconst) REFERENCES title_akas(tconst);
  
