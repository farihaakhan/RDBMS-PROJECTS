Fariha T Khan

Professor Zombory

Math 290

13 October 2022

1. Installed Tableu Public desktop and created AWS account
2. 
- Assuming the question asked to count thee columns of both vendorid and pickup date and to group by them.  

	    select vendorid,tpep_dropoff_datetime, count (*) as count
	    from yellow_taxi
	    group by vendorid,tpep_dropoff_datetime
	    order by vendorid,tpep_dropoff_datetime;

\
After running the script for exercise two I ran into error with Dbeaver memory space. I tried different [solutions](https://docs.google.com/document/d/1Y-8RQnRC49g9j8PUGpPp8sS_jouzMwvhqrKNcueBKfk/edit?usp=sharing) to resolve the problem. 
\
 As mentioned in the doc I could not to fix the error with Dbeaver so I was not able to test out the queries. 
 
  
 - What is the mean, median, minimum, and maximum trip_distance by vendor between 5:00 and 6:00 AM (not including 6:00 AM)?

		SELECT MIN(trip_distance) AS Trip_Distance
		FROM yellow_taxi
		Where tpep_pickup_datetime >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND
		DATEPART(hour , '2020-01-01 05:00') and DATEPART(hour ,'2020-01-01 05:59');

		SELECT MAX(trip_distance) AS Trip_Distance
		FROM yellow_taxi
		Where tpep_pickup_datetime >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND
		DATEPART(hour , '2020-01-01 05:00') and DATEPART(hour ,'2020-01-01 05:59');

		SELECT AVG(trip_distance) AS Trip_Distance
		FROM yellow_taxi
		Where tpep_pickup_datetime >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND
		DATEPART(hour , '2020-01-01 05:00') and DATEPART(hour ,'2020-01-01 05:59');
	
		SELECT vendorid,trip_distance, tpep_pickup_datetime, 
		PERCENTILE_CONT(0.5) 
        WITHIN GROUP (ORDER BY trip_distance) 
        OVER (PARTITION BY vendorid)
        AS Median_distance
        FROM yellow_taxi
        ORDER BY vendorid, trip_distance;
		
		
Assuming the min,max and avg from the whole year.

Between operator is inclusive so if I had put 7 instead of 6 then it would include the time 6 am.

- What day in 2018 had the least / most amount of unique trips?

	    select distinct (tpep_pickup_datetime)
		from yellow_taxi
		where Datepart(year, '2018') as trip_year
		group by tpep_pickup_datetime
		order by desc 

3.  
- What was the average tip percentage (tip_amount/total_amount) for unique trips in 2018?

	    select avg (tip_amount/total_amount) as Average_Tip
	    from 
		(select distinct (tpep_pickup_datetime)
		from yellow_taxi
		where Datepart(year, '2020') as trip_year
		group by tpep_pickup_datetime
		order by desc 
		)as p ;
Previous query from exercise 2 as subquery. 
 - What was the average tip percentage by drop off hour for unique trips in 2018?
 
	    select distinct (*)
	    from (
	    	select avg
	    	(tip_amount/total_amount) as Average_Tip
	    	from yellow_taxi
	    	where extract (hour from tpep_dropoff_datetime) as drop_hour
	    	group by drop_hour
	    	order drop_hour by desc
	    	)as h ;

Year is 2020 as I am using the 2020 dataset

4.  Assuming the date is the "tpep_pickup_datetime" column.

	    create view daily_tip_percentage_by_distance as
		SELECT tpep_pickup_datetime, trip_mileage 
			CASE WHEN trip_mileage >= 0 and trip_mileage < 1 then '0-1 mile'
		            WHEN trip_mileage >= 0 and trip_mileage < 1 then '0-1 mile'
		            WHEN trip_mileage >= 1 and trip_mileage < 2 then '1-2 mile'
		            WHEN trip_mileage >= 2 and trip_mileage < 3 then '2-3 mile'
		            WHEN trip_mileage >= 3 and trip_mileage < 4 then '3-4 mile'
		            WHEN trip_mileage >= 4 and trip_mileage < 5 then '4-5 mile'
		            WHEN trip_mileage >= 5 then '5+ mile'
		            END as trip_mileage_band
		            order by tpep_pickup_datetime, trip_mileage;
