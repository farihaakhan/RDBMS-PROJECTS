--Question 1: What is the total runtime of all movies in the IMDB database where Nicolas Cage appeared as an actor?
select
	sum(cast(tb."runtimeMinutes" as int)) as NicolasCage_runtime_mins
from
	"IMDB".public.title_basics tb
full outer join "IMDB".public.title_principals tp
on
tb.tconst = tp.tconst 
full outer join name_basics nb
on
tp.nconst = nb.nconst 
where
	nb."primaryName" = 'Nicolas Cage'
	and 
tb."titleType" = 'movie'
	and 
tp.category  = 'actor'
and 
tb."runtimeMinutes" != 'N'
;


select sum(runtimeminutes) as cage_runtime
	from xf_title_principals xtp 
full outer join xf_name_basics xnb 
	on xtp.nconst = xnb.nconst 
full outer join xf_title_basics xtb
	on xtp.tconst = xtb.tconst
where xnb."primaryName" = 'Nicolas Cage'
	and xtb."titleType" = 'movie'
	and category = 'actor'

--Question 2: Which actor had the most number of titles in 2012?
select
	nb."primaryName",
	count(*) movies
from
	title_principals tp
full outer join name_basics nb 
on
	tp.nconst = nb.nconst 

full outer join title_basics tb 
on tb.tconst = tp.tconst

where category = 'actor' and tb."startYear" = '2012'
group by nb."primaryName"
order by movies desc;


select xnb."primaryName", count(*) movies
from xf_title_principals xtp 
full outer join xf_name_basics xnb 
	on xtp.nconst = xnb.nconst 
full outer join xf_title_basics xtb 
	on xtb.tconst = xtp.tconst
where category = 'actor' 
	and xtb.startyear = '2012'
	group by xnb."primaryName"
	order by movies desc	


--Question 3: What Nicolas Cage's move received the highest average rating?
select
	tr."averageRating" as NicolasCage_Avg_rating ,
	tb."primaryTitle"as NicolasCage_Movie
from
	title_principals tp
full outer join name_basics nb 
on
	tp.nconst = nb.nconst
full outer join title_basics tb 
on
	tp.tconst = tb.tconst
full outer join title_ratings tr 
on
	tp.tconst = tr.tconst
where
	nb."primaryName" = 'Nicolas Cage'
	and tr."averageRating" is not null
	and tb."titleType" = 'movie'
order by
	tr."averageRating" desc;
	

select xtb."primaryTitle" as NicolasCage_Movie, xtr.averagerating as NicolasCage_Avg_rating 
from xf_title_principals xtp 
full outer join xf_name_basics xnb 
	on xtp.nconst = xnb.nconst
full outer join xf_title_basics xtb  
	on xtp.tconst = xtb.tconst
full outer join xf_title_ratings xtr
	on xtp.tconst = xtr.tconst
where xnb."primaryName" = 'Nicolas Cage'
	and xtr.averagerating is not null
	and xtb."titleType" = 'movie'
	order by xtr.averagerating desc 
	

--Question 4: Which short move received the highest average rating in 2009?
select
	tb."primaryTitle" as shortMovie,
	tr."averageRating" as Avg_Rating
from
	title_basics tb
full outer join title_ratings tr 
on
	tb.tconst = tr.tconst 
where tb."startYear"= '2009'and tb."titleType" = 'short'and tr."averageRating" is not null
order by tr."averageRating" desc;


select xtb."primaryTitle" as ShortMovie, xtr."averagerating" as Avg_Rating
from xf_title_basics xtb 
full outer join xf_title_ratings xtr  
	on xtb.tconst = xtr.tconst 
where xtb."startyear"= '2009' 
	and xtb."titleType" = 'short'
	and xtr."averagerating" is not null
	order by xtr."averagerating" desc	


--Question 5: Return the top 10 actors with most movies where the runtime is between 45 and 60 minutes and the start year is between 2000 and 2010?

select xnb."primaryName", count(*) TotalMovies
from  xf_name_basics xnb
full outer join xf_title_principals xtp 
	on xtp."nconst" = xnb."nconst"
full outer join xf_title_basics xtb
	on xtp."tconst" = xtb."tconst"
where xtp."category" = 'actor'
	and xtb.startyear between 2000 and 2010
	and xtb.runtimeminutes between 45 and 60
	group by "primaryName"
	order by TotalMovies desc
	limit 10
	
--Question 6: What are the top 10 highly rated movies with only three words in their titles?

select xtb."primaryTitle", count(numvotes) as Total
from xf_title_ratings xtr 
full outer join xf_title_basics xtb 
	on xtr.tconst = xtb.tconst 
	where xtb."titleType" = 'movie'
	and length(xtb."primaryTitle") = 3
	group by "primaryTitle"
	order by Total desc
	limit 10
	
--Question 7: Extra credit: Are three-word movie titles more popular than two-word titles?

--Question 8: Extra credit: Does this (see question 7) change over time?
