Fariha T Khan

Professor Zombory

Math 290

20 October 2022

## 1

 Installed Tableau Public desktop and created an AWS account

## 2

Downloaded and unzipped the files. One issue I faced while unzipping was that the files were a .gz file which can't be unzipped with Windows built-in Zip file extract option. So I used the "7-Zip File Manager" app to extract the files. 
- Created individual tables for all the different datasets with all having varchar datatype. 

	    create table im.public.title_akas
	    create table im.public.title_basics
	    create table im.public.title_crew
	    create table im.public.title_episode
	    create table im.public.title_principals
	    create table im.public.title_ratings
	    create table im.public.name_basics

- Using the **COPY FROM** command imported all the data in the respective tables.

		copy  im.public.name_basics from 'C:\sampledb\name.basics.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_akas from 'C:\sampledb\title.akas.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_basics from 'C:\sampledb\title.basics.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_crew from 'C:\sampledb\title.crew.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_episode from 'C:\sampledb\title.episode.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_principals from 'C:\sampledb\title.principals.tsv\data.tsv' delimiter E'\t';
		copy  im.public.title_ratings from 'C:\sampledb\title.ratings.tsv\data.tsv' delimiter E'\t';



- **SELECT Statement** 

All of the tables except the "name_basics" table, had extra rows with their column names. 

	    SELECT * FROM title_akas
		LIMIT 100;

- Used the Select statement again to check how many rows have the same value as their column names. 

    select * 
    from title_akas
    where "titleId"  = 'titleId'  
    limit 100;

- **DELETE Command**

Implemented this code to check what happens if I remove the row with the value containing their column name. 

    DELETE
    from title_akas
    where "titleId"  = 'titleId';

With the statement, the row was removed from the table. Then I rechecked to see if all the other rows were there or not. 
	
	SELECT * FROM title_akas
	LIMIT 100;
Checked with the COUNT statement too as before and after. After deleting only one row was removed. 

- **COPY TO**

Used the given code to export the TSV as CSV on my device. 

    COPY title_akas("titleId", ordering, title, region, language, types, attributes, "isOriginalTitle") 
    TO 'C:\sampledb\title.akas.tsv\title_akas.csv' DELIMITER ',' CSV HEADER;


# 3

 **Cardinality**
 
Cardinality is the uniqueness of data in a specific column of a table.
To find the cardinality of each column we need to find how many of the total rows of each table are distinct. 

	    select 'distinct tconst' as TitleRating, count(distinct "tconst") from "title_ratings"
	    union
	    select 'distinct averageRating'as TitleRating, count(distinct "averageRating") from "title_ratings"
	    union
	    select 'distinct numVotes' as TitleRating, count(distinct "numVotes") from "title_ratings"
- **Primary Key** 
	- For the **name_basics** table, I choose nconst as the primary key as it is described as a unique identifier in the IMBD dataset documentation. Also, when I compared the total distinct rows and total rows, both numbers were the same.
	- For the **title_akas** table I choose titleId and ordering as Composite Primary key (given). But also both of them are unique identifiers for the table. 
	- For the **title_basic** table I choose primaryTitle and originalTitle because both are unique names. Because of two separate titles, there will be fewer possibilities of duplicates.
		- Had to add tconst as Composite Key along with them because both of those columns had similiar values. 
	- For the **title_episode** table I choose parentTconst and tconst as Composite Primary Key. In the documents, both of them are defined as an identifier. Also, the total number of rows and the distinct number of tconst were the same. But adding parentTconst would ensure no other same TV series has the same episode id. As mentioned in the document tconst in this table is the "identifier of the episode" not an identifier of the title like other tables, so I am assuming it's not a Foreign Key. 
	- For the table **title_principals** I choose three columns to be Composite Key. tconst, ordering and nconst will prevent a cast/crew from the same titles to added again in the table.
	- Same for the table **title_crew** table. tconst, directors and writers as Composite Key will prevent duplicates.
	- For the **title_ratings** I decided to create a new column as a unique identifier for the table. Although the distinct numbers of tconst rows were the same as the total, tconst is a Foreign Key. And other column numbers are significantly low than the total. Creating another column with an identifier along with tconst as Composite Primary Key will help prevent duplicates. 

- **ALTER TABLE** 
Based on my analysis, alternated columns of the tables. 

	    ALTER TABLE im.public.title_akas ADD PRIMARY KEY ("titleId", ordering);
	    ALTER TABLE im.public.name_basics ADD PRIMARY KEY (nconst);
	    ALTER TABLE im.public.title_basics ADD PRIMARY KEY ("tconst","primaryTitle", "originalTitle");
	    ALTER TABLE im.public.title_episode ADD PRIMARY KEY ("parentTconst", "tconst");
	    ALTER TABLE im.public.title_principals ADD PRIMARY KEY ("tconst", "ordering","nconst");
	    ALTER TABLE im.public.title_crew ADD PRIMARY KEY ("tconst", "directors","writers");



# 4

 **EXCEPT**

	    select count(*)
	    from 
	    (select (tconst)
	     from im.public.title_ratings
	     EXCEPT
	     select (tconst)
	     from im.public.title_basics
	     ) p


After running the script the result showed 0, meaning all the tconst rows  from title_ratings table are available in title_basics table.   

- **EXCEPT COLUMNS** 

	     select *
	    	from 
	    	(select (tconst)
	    	 from im.public.title_ratings
	    	 EXCEPT
	    	 select (tconst)
	    	 from im.public.title_basics
	    	 ) p

As the result was 0, the result would show empty table.
- **INTERSECT**

	    select count(*)
	    from 
	    	(select (tconst)
	    	 from im.public.title_ratings
	    	 INTERSECT
	    	 select (tconst)
	    	 from im.public.title_basics
	    	 ) p

There are about **1241074** records that show up in both of the tables. 

## 5
- **FOREIGN KEY**

	    ALTER TABLE title_ratings
	    ADD FOREIGN KEY (tconst) REFERENCES title_basics(tconst);

It did not work because there was an error. The following error shows that the tconst key on title_basics table is not unique. 
A foreign key must reference columns that are either primary key or form a unique constraint. tconst is a part of the Composite Key for its table. But because it is a composite key, it is associated with other columns, so I was able to make it a CPK. But the column by itself is not unique.

> SQL Error [42830]: ERROR: there is no unique constraint matching given keys for referenced table "title_basics"

