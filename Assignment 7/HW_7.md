
Fariha T Khan

Professor Zombory

Math 290

28 October 2022


## 1
1. Checked to see if all the column's datatype is varchar or not.

	    select table_name, column_name, data_type 
	    from im.information_schema.columns
	    where  table_schema = 'public' and table_name = 'title_basic';
	    

[Returned](https://docs.google.com/document/d/1LDFHWNyjSkjPJszUW5NBrUDxSFj6NAPFnG4NcqPr26Y/edit?usp=sharing) empty table which shows all the datatypes are varchar. 

2. Created views for all the tables.

	    create view im.public.etl_title_basics_v
	    create view im.public.etl_name_basics_v
	    create view im.public.etl_title_crew_v
	    create view im.public.etl_title_episode_v
	    create view im.public.etl_title_principals_v
	    create view im.public.etl_title_ratings_v

3. Created a physical table from the views.
 
        create table im.public.xf_name_basics
        as
        select * from im.public.etl_name_basics_v;

 - There was an error with the name_basics table in the birthYear column, the datatype could not be set as an integer, DATE, or TimeStamp. After looking at the dataset with the SELECT statement, I found out that the column did not contain an integer value. So I left the datatype as varchar.

4. Changed some of the table's Primary Key and Foreign key relationships from the previous homework.

Most of the tables contained the Primary key from the title_aka table. So, I added them as foreign keys in other tables. Some tables do not have Primary Keys as well.


## 2

 1. Between operations is inclusive. So the script is including both minutes 42 and 77.
 
	    SELECT count(*) FROM xf_title_basics
	    WHERE runtimeminutes BETWEEN 42 AND 77;

 2.  According to the PostgreSQL [document](https://www.postgresql.org/docs/current/datatype-boolean.html) , "1" is a representation of  the boolean = 'true'. So the isAdult column must be 1 for it to be accounted for in the script. 


        SELECT AVG(runtimeminutes) as AverageRuntime
        FROM xf_title_basics
        WHERE isadult = '1';

 3. The Cartesian product of the **xf_title_basic** table with itself would return the same table because it cross-joins all the rows in both the tables listed in a query. Each row in the first table is paired with all the rows in the second table.
 The query should not be run because it would return the same value. It takes a long time to execute the query. The runtime will keep on running.
 
 4.  **Round function** will round the decimal. ROUND(_number_,  _decimals_) or round(30.222,0) rounds the decimal to the nearest 0. 


        select round (AVG (runtimeminutes),0) as roundedAVG
        FROM xf_title_basics
        WHERE genres [1] = 'Action'

5.  **Relative frequency** relationship will show how many times each genre appears in the dataset.

		select * from (
		select genres, count(*) DistinctGenres
		from xf_title_basics
		group by genres
		order by DistinctGenres desc
		)g

6.  **Unnest** function will break down the array from being in a set to individual columns. It expands the array to a set of rows. 

		SELECT genresArray, count(*) as Total_Genres 
		FROM xf_title_basics xtb, unnest(xtb.genres) as genresArray
		GROUP BY genresArray;


## 3

1.  **Full Outer Join** will return the records that appear in both tables. 

	    SELECT xf_title_basics.tconst, xf_title_crew.tconst
	    FROM xf_title_basics
	    FULL OUTER JOIN xf_title_crew ON xf_title_basics.tconst = xf_title_crew.tconst;

2.  I tried different approaches to group the column by the title_basic.tconst column. But I kept running into error. With the script, the result could not be grouped by the title_basic table. 

