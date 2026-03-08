DROP TABLE IF EXISTS netflix_title;
CREATE TABLE netflix_title
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

select * from netflix_title
where show_id is null
	or type is null
	or title is null
	or director is null
	or casts is null
	or country is null
	or date_added is null
	or release_year is null
	or rating is null
	or duration is null
	or listed_in is null
	or description is null

select count(*) from netflix_title
select distinct(type) from netflix_title

-- Business Problems & Solutions
-- 1. Count the number of Movies vs TV Shows
select type,count(*) from netflix_title
group by type

-- 2. Find the most common rating for movies and TV shows
select 
	type,
	rating from
	(
		select 
			type,
			rating,
			count(*),
			rank() over(partition by type order by count(*) desc) as ranking
		from netflix_title
		group by type,rating
		order by type,count desc
	) where ranking = 1

-- 3. List all movies released in a specific year (e.g., 2020)
select 
	type,
	title, 
	release_year from netflix_title
where release_year='2020' and type='Movie'

-- 4. Find the top 5 countries with the most content on Netflix
select * from
(
	select 
		count(*),
		unnest(String_to_array(country,',')) as new_country
	from netflix_title
	group by new_country
	order by count desc
) limit 5


-- 5. Identify the longest movie
select * from netflix_title
where type = 'Movie' and duration= (select max(duration) from netflix_title)

-- 6. Find content added in the last 8 years
select * from netflix_title
where To_DATE(date_added, 'MONTH DD, YYYY') >= CURRENT_DATE - INTERVAL '8 years'


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix_title
where director = 'Rajiv Chilaka'

select * from netflix_title
where director ilike '%Rajiv Chilaka%'

select * from (
	select *,
	unnest(String_to_array(director,',')) as new_director
	from netflix_title
) where director='Rajiv Chilaka'

select * from (
	select *,
	unnest(String_to_array(director,',')) as new_director
	from netflix_title
) where director ilike '%Rajiv Chilaka%'

-- 8. List all TV shows with more than 5 seasons
select * from netflix_title
where type = 'TV Show' and split_part(duration ,' ',1)::int > 5


-- 9. Count the number of content items in each genre
select 
	count(show_id),
	unnest(string_to_array(listed_in,',')) as genre
from netflix_title
group by genre

/*10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release! */
WITH total AS (
    SELECT COUNT(*) AS total_titles
    FROM netflix_title
    WHERE country = 'India'
)
SELECT
	country,
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(show_id) AS total_released,
    ROUND(COUNT(show_id)::numeric / total.total_titles * 100, 2) AS avg_released
FROM netflix_title, total
WHERE country = 'India'
GROUP BY year, total.total_titles, country
ORDER BY total_released DESC
LIMIT 5;


-- 11. List all movies that are documentaries
select 
	type,
	title,
	listed_in
from netflix_title
where type ='Movie' and listed_in ilike '%documentaries%'


-- 12. Find all content without a director
select 
	type,
	title,
	director
from netflix_title
where director is null or director=''


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select 
	title,
	release_year,
	casts
from netflix_title
where type='Movie'
and casts ilike '%Salman Khan%'
and  release_year >= Extract(year from current_Date) - 10
order by release_year Desc;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select * from 
(
	select 
		country,
		unnest(String_to_array(casts,',')) as actor,
		count(*) as movie_count
		from netflix_title
		where country = 'India' and type = 'Movie'
		group by actor, country
		order by movie_count desc
) limit 10


/*15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category. */
With content_check as (
	select 
		title,
		case 
		when description ilike '%kill%' or  description ilike '%violence%' then 'Bad'
		else 'Good'
		end as category 
		from netflix_title
) select category,
count(*) as total_content
from content_check
group by category





