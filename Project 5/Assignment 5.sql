--2 
	--a
   select vendorid,tpep_dropoff_datetime, count (*) as count
   from yellow_taxi
   group by vendorid,tpep_dropoff_datetime
  order by vendorid,tpep_dropoff_datetime;


	--b 
	SELECT MIN(trip_distance) AS Trip_Distance
	FROM yellow_taxi
	Where tpep_pickup_datetime  >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND 
	DATEPART(hour , '2020-01-01 05:00') and  DATEPART(hour ,'2020-01-01 05:59');
	--c 
	SELECT MAX(trip_distance) AS Trip_Distance
	FROM yellow_taxi
	Where tpep_pickup_datetime  >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND 
	DATEPART(hour , '2020-01-01 05:00') and  DATEPART(hour ,'2020-01-01 05:59');

	--d 
	SELECT AVG(trip_distance) AS Trip_Distance
	FROM yellow_taxi
	Where tpep_pickup_datetime  >= '2020-01-01 00:00:00' and
		tpep_pickup_datetime <= '2020-12-31 23:59:00' AND 
	DATEPART(hour , '2020-01-01 05:00') and  DATEPART(hour ,'2020-01-01 05:59');

	--e 
	select
	vendorid,trip_distance, tpep_pickup_datetime, 
	PERCENTILE_CONT(0.5) 
	WITHIN GROUP (ORDER BY trip_distance) 
	OVER (PARTITION BY vendorid)
	AS Median_distance
	FROM yellow_taxi
	ORDER BY vendorid, trip_distance;

	--f 
	select distinct (tpep_pickup_datetime)
	from yellow_taxi
	where Datepart(year, '2018') as trip_year
	group by tpep_pickup_datetime
	order by desc 
	
--3 
	--a 
	select avg (tip_amount/total_amount) as Average_Tip
	from 
	(select distinct (tpep_pickup_datetime)
	from yellow_taxi
	where Datepart(year, '2018') as trip_year
	group by tpep_pickup_datetime
	order by desc 
	)as q ;
	
	--b 
	select distinct (*)
	from (
	select avg (tip_amount/total_amount) as Average_Tip
	from yellow_taxi
	where extract (hour from tpep_dropoff_datetime) as drop_hour
	group by drop_hour
	order drop_hour by desc 
	)as h ;
	

--4 
	--a
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
