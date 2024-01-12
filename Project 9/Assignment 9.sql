-- Question 2: What are the first and last names of all the actors cast in the movie 'Lord of war'? What roles did they play in that production?
select 
xnb."primaryName" as actor_Of_Actor
from xf_name_basics xnb 
full outer join xf_title_principals xtp 
on xnb.nconst = xtp .nconst 
full outer join xf_title_basics xtb 
on xtp.tconst = xtb.tconst 
where xtp.category  = 'actor' and xtb."titleType"  = 'movie'
;

-- Question 3: What are the highest-rated Comedy shorts between 2000 and 2010?
select 
xtb."primaryTitle"
from xf_title_basics xtb 
full outer join xf_title_ratings xtr 
on xtb.tconst = xtr.tconst 
where xtb."titleType" = 'short' and xtb.genres = 'Comedy'and xtb."startYear" >= 2000 and xtb."endYear" <= 2010
order by xtr.averagerating 
;

-- Question 4: What is the average number of votes for movies rated between 0-1, 1-2, 2-3, 3-4, 4-5?
select avg(xtr."numVotes")
from xf_title_ratings xtr 
full outer join xf_title_principals xtp 
on xtr.tconst = xtp.tconst 
where xtp.category = 'movie'
group by xtr.averagerating  where averagerating <5
;

select avg(xtr.numvotes) as AverageVotes
from xf_title_ratings xtr 
full outer join xf_title_principals xtp 
on xtr.tconst = xtp.tconst 
where xtp.category = 'movie' and
CASE WHEN averagerating >= 0 and averagerating < 1 then '0-1'
	            WHEN averagerating >= 1 and averagerating < 2 then '1-2'
	            WHEN averagerating >= 2 and averagerating < 3 then '2-3'
	            WHEN averagerating >= 3 and averagerating < 4 then '3-4'
	            WHEN averagerating >= 4 and averagerating < 5 then '4-5'
	            END as AverageVotes
group by AverageVotes
