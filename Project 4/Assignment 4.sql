-- 1
select 'count distinct VendorID' as operation_description, count(distinct "VendorID") from "taxidata"."public"."taxi_data"
union
select 'count distinct tpep_pickup_datetime'as operation_description, count(distinct "tpep_pickup_datetime") from "taxidata"."public"."taxi_data"
union
select 'count distinct tpep_dropoff_datetime'as operation_description, count(distinct "tpep_dropoff_datetime") from "taxidata"."public"."taxi_data"
union
select 'count distinct passenger_count'as operation_description, count(distinct "passenger_count") from "taxidata"."public"."taxi_data"
union
select 'count distinct trip_distance'as operation_description, count(distinct "trip_distance") from "taxidata"."public"."taxi_data"
union
select 'count distinct PULocationID'as operation_description, count(distinct "PULocationID") from "taxidata"."public"."taxi_data"
union
select 'count distinct DOLocationID'as operation_description, count(distinct "DOLocationID") from "taxidata"."public"."taxi_data"
union
select 'count distinct RatecodeID'as operation_description, count(distinct "RatecodeID") from "taxidata"."public"."taxi_data"
union
select 'count distinct store_and_fwd_flag'as operation_description, count(distinct "store_and_fwd_flag") from "taxidata"."public"."taxi_data"
union
select 'count distinct fare_amount'as operation_description, count(distinct "fare_amount") from "taxidata"."public"."taxi_data"
union
select 'count distinct payment_type'as operation_description, count(distinct "payment_type") from "taxidata"."public"."taxi_data"
union
select 'count distinct fare_amount'as operation_description, count(distinct "fare_amount") from "taxidata"."public"."taxi_data"
union
select 'count distinct extra'as operation_description, count(distinct "extra") from "taxidata"."public"."taxi_data"
union
select 'count distinct mta_tax'as operation_description, count(distinct "mta_tax") from "taxidata"."public"."taxi_data"
union
select 'count distinct tip_amount'as operation_description, count(distinct "tip_amount") from "taxidata"."public"."taxi_data"
union
select 'count distinct tolls_amount'as operation_description, count(distinct "tolls_amount") from "taxidata"."public"."taxi_data"
union
select 'count distinct total_amount'as operation_description, count(distinct "total_amount") from "taxidata"."public"."taxi_data"
union
select 'count distinct congestion_surcharge'as operation_description, count(distinct "congestion_surcharge") from "taxidata"."public"."taxi_data"
	    
--2 
	--all across
	   select count(*) as distinct_observation_count from (select distinct "vendorid","tpep_pickup_datetime","tpep_dropoff_datetime","passenger_count","trip_distance",
	   "pulocationid","store_and_fwd_flag","fare_amount","extra","mta_tax","tip_amount","tolls_amount","total_amount","congestion_surcharge","ratecodeid" from "postgres"."public"."yellow_taxi") as sub_query;	   
	   
	 -- Combination of columns
	 select count(*) as distinct_observation_count from (select distinct "vendorid", "ratecodeid" from "postgres"."public"."yellow_taxi") as sub_query;
	select count(*) as distinct_observation_count from (select distinct "vendorid", "extra" from "postgres"."public"."yellow_taxi") as sub_query;
	select count(*) as distinct_observation_count from (select distinct "vendorid", "mta_tax" from "postgres"."public"."yellow_taxi") as sub_query;
	select count(*) as distinct_observation_count from (select distinct "vendorid", "tpep_pickup_datetime" from "postgres"."public"."yellow_taxi") as sub_query;
	  
--3 
	--a
	select count (passenger_count) as Total_Passenger 
	from yellow_taxi 
	where passenger_count= 5;
	
	--b
	SELECT COUNT(DISTINCT passenger_count) 
	FROM yellow_taxi
	where passenger_count > 3 ;

	--c
	select count (tpep_pickup_datetime) as Total_Pickuptimes
	from yellow_taxi 
	where tpep_pickup_datetime between  '2020-04-01 00:00:00' and '2020-05-01 00:00:00';

	select count (tpep_pickup_datetime) as Total_Pickuptimes
	from yellow_taxi 
	where tpep_pickup_datetime >= '2018-04-01 00:00:00' and
	tpep_pickup_datetime <= '2018-05-01 00:00:00';

	--d
	SELECT COUNT(DISTINCT tpep_pickup_datetime) FROM yellow_taxi
	where tpep_pickup_datetime >= '2020-06-01 00:00:00' and
	tpep_pickup_datetime <= '2020-06-30 23:59:00'  and 
	tip_amount >= 5;

	--e
	SELECT SUM(tip_amount) as Total_Tip
	FROM yellow_taxi;

--4
	DELETE FROM yellow_taxi WHERE vendorid = 2;

	select count (vendorid) 
	from yellow_taxi 
	where vendorid = 2;

--5 
	VACUUM FULL;

--6 
	TRUNCATE TABLE yellow_taxi ;	
