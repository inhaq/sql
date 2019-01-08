-- SELECT within SELECT

-- List each country name where the population is larger than that of 'Russia'.
SELECT name 
FROM world
WHERE population > 
(SELECT population FROM world WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name 
FROM world
WHERE continent='Europe' AND gdp/population >
(SELECT gdp/population FROM world WHERE name='United Kingdom')

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name,continent
FROM world
WHERE continent IN 
(SELECT continent FROM world WHERE name IN ('Australia','Argentina'))
ORDER BY name

-- Which country has a population that is more than Canada but less than Poland? 
SELECT name,population
FROM world
WHERE population BETWEEN
(SELECT population+1 FROM world WHERE name='Canada')
AND
(SELECT population-1 FROM world WHERE name='Poland')

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name,
CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name='Germany')),'%')
FROM world
WHERE continent='Europe'

-- Which countries have a GDP greater than every country in Europe?
SELECT name
FROM world 
WHERE gdp > ALL
(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL)

-- Find the largest country (by area) in each continent, show the continent, the name and the area
SELECT continent, name, area 
FROM world x
WHERE area >= ALL
(SELECT area FROM world y WHERE y.continent=x.continent and area > 0 )

-- List each continent and the name of the country that comes first alphabetically.
SELECT continent,name
FROM world x
WHERE x.name <= ALL 
(SELECT name FROM world y WHERE x.continent=y.continent)

-- Find the continents where all countries have a population <= 25000000
SELECT name,continent,population
FROM world x
WHERE 25000000 >= ALL 
(SELECT population FROM world y WHERE x.continent=y.continent AND y.population>0)

-- Some countries have populations more than three times that of any of their neighbours (in the same continent).
SELECT name, continent 
FROM world x WHERE
population > ALL
(SELECT population*3 FROM world y WHERE y.continent = x.continent AND y.name != x.name)