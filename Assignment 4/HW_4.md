Fariha T Khan

Professor Zombory

Math 290

06 October 2022

 **0. New branch**
 Created a new branch called (fariha_Aracely_hw4) under the main branch. Uploaded two files to the folder.
 - Reimported the dataset 2020 Yellow Taxi Trip instead of the 2018 version, as so many rows from the table were missing. 
	``DELETE FROM yellow_taxi;``
- After importing the new dataset, **24648499** rows were found.

			SELECT COUNT (*)
			FROM yellow_taxi

 **1. Distinct Records**
 - Vendorid should not be 3 as Distinct returns the number of unique non-null values. 

	    SELECT COUNT(DISTINCT vendorid) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT tpep_pickup_datetime) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT tpep_dropoff_datetime) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT Passenger_count) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT Trip_distance) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT PULocationID) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT DOLocationID) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT RateCodeID) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT Store_and_fwd_flag) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT Fare_amount) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT Payment_type) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT fare_amount) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT extra) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT mta_tax) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT tip_amount) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT tolls_amount) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT total_amount) FROM yellow_taxi;
	    SELECT COUNT(DISTINCT congestion_surcharge) FROM yellow_taxi;

| Column Name | Distincts  |
|--|--|
| vendorid | 2 |
| tpep_pickup_datetime | 11775710 |
| tpep_dropoff_datetime |11776096  |
|Passenger_count  |10  |
|Trip_distance  |7375  |
|PULocationID  | 262 |
|DOLocationID  | 263 |
|RateCodeID| 7 |
|Store_and_fwd_flag| 3 |
|payment_type| 3 |
|Fare_amount|10301 |
|extra| 370 |
|mta_tax| 24 |
|improvement_surcharge| 3 |
|tip_amount| 5196 |
|tolls_amount| 1915 |
|total_amount| 10301  |
|congestion_surcharge| 5 |

- I tried to reduce the number of Select statements but could not. Some [examples](https://docs.google.com/document/d/1SWpV9Ri2VTOEnDytArbT18O_N8Uy9QDfgtGulb0AsoU/edit?usp=sharing) I tried were with Aggregate Function (Group by, Order by) also with Alias.
- The total distinct rows from the above results is approximately **23587846**. It could mean that either the rest of the rows are duplicates or contain null values.

 **2. Subquery Exercise :** 
 A subquery all across the 17 columns. 

	    select count(*) as distinct_observation_count from (select distinct "vendorid","tpep_pickup_datetime","tpep_dropoff_datetime","passenger_count","trip_distance","pulocationid","store_and_fwd_flag","fare_amount","extra","mta_tax","tip_amount","tolls_amount","total_amount","congestion_surcharge","ratecodeid" from "postgres"."public"."yellow_taxi") as sub_query;
		 
- After three crucial facts about the dataset, I don't think any of the columns could serve as a Primary Key. 
- After running multiple combinations of columns none of them could serve as a Primary Key. Most of the results were in thousands. But the combination of "Vendorid" and "mta_tax" was 35 and "Vendorid" and "ratecodeid" was only 15. 

		select count(*) as distinct_observation_count from (select distinct "vendorid", "ratecodeid" from "postgres"."public"."yellow_taxi") as sub_query;

 **3.  Where Clause :** 
 - How many rows have a "passenger_count" equal to 5?

       select count (passenger_count) as Total_Passenger
       from yellow_taxi
       where passenger_count= 5;
    

 - How many distinct trips have a "passenger_count" greater than 3?

       SELECT COUNT(DISTINCT passenger_count)
       FROM yellow_taxi
       where passenger_count > 3 ;
    

 - How many rows have a tpep_pickup_datetime between '2018-04-01 00:00:00' and '2018-05-01 00:00:00'?
 
       select count (tpep_pickup_datetime) as Total_Pickuptimes
       from yellow_taxi
       where tpep_pickup_datetime between '2020-04-01 00:00:00' and '2020-05-01 00:00:00';
    




- How many distinct trips occurred in June where the tip_amount was greater than equal to $5.00?

       select count (tpep_pickup_datetime) as Total_Pickuptimes
       from yellow_taxi 
       where tpep_pickup_datetime >= '2020-04-01 00:00:00' and tpep_pickup_datetime <= '2020-05-01 00:00:00';
       


-   How many distinct trips occurred in May where the passenger_count was greater than three and tip_amount was between $2.00 and $5.00?

	    SELECT COUNT(DISTINCT tpep_pickup_datetime) 
	    FROM yellow_taxi
	    where tpep_pickup_datetime >= '2020-06-01 00:00:00' and tpep_pickup_datetime <= '2020-06-30 23:59:00' and
	    tip_amount >= 5;
    

-   What is the sum of tip_amount in the  `2018_Yellow_Taxi_Trip_Data`  dataset? (Hint: use the SUM() function to find the answer)
	- The answer can be equivalent to the question "How much tip did taxi drivers collected in total in 2018" because `SUM()` function returns the total sum of a numeric column. So adding up all the tip amounts together. 

	       SELECT SUM(tip_amount) as Total_Tip
	       FROM yellow_taxi;    

|Total_Tip|
|--|
| 51319673.11954734 |

**4. The Base and the Database folder's size associated with the Database**
`show data_directory;`
`select * from pg_catalog.pg_stat_database;`

|folder_name| size |
|--|--|
|base| 4.4 GB 4,343,696,175 bytes |
|databseid| 13754  |

**Delete**

	    DELETE FROM yellow_taxi WHERE vendorid = 2;

- The size of the base folder and the size of the database folder after the delete: 

|folder_name| size |
|--|--|
|base| 4.04 GB 4,343,696,175 bytes |
|databseid| 13754  |
- The Base folder size decreased. 

The number of rows after delete

	    select count (vendorid) 
	    from yellow_taxi 
	    where vendorid = 2;
**5.  Vaccum** 
The vacuum helps physically remove the deleted tuples from the Database. After deleting itself, the tuples are not physically removed from their table; they remain present until a VACUUM is done.
- the query was successful. 

**6. Truncate**
Deleted the data inside a table, but not the table itself.

    TRUNCATE TABLE yellow_taxi ;
