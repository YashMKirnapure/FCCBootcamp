SELECT TOP 20 * FROM CovidDeaths$ 
WHERE continent is not null
ORDER BY 3,4;

--SELECT TOP 20 * FROM CovidVaccinations$ ORDER BY 3,4;

--Select the Data that we are going to be using
SELECT Location, date, total_cases , 
new_cases, total_deaths, Population 
FROM CovidDeaths$ 
WHERE continent is not null
ORDER BY 1,2;

--Looking at Total Cases vs Total Deaths
SELECT Location,date,total_cases,total_deaths,
(total_deaths/total_cases) * 100 AS DeathPercentage
FROM CovidDeaths$ 
WHERE continent is not null
ORDER BY 1,2;

--Shows the likelihood of dying if you contract covid in your country
SELECT Location,date,total_cases,total_deaths,
(total_deaths/total_cases) * 100 AS DeathPercentage
FROM CovidDeaths$ 
WHERE location LIKE '%India%' AND 
continent is not null
ORDER BY 1,2;

--Looking at total cases vs population
--shows what percentage of population got covid
SELECT Location,date,total_cases,Population,
(total_cases/population) * 100
FROM CovidDeaths$ WHERE location LIKE '%India%'  AND
continent is not null
ORDER BY 1,2;

--Looking at Countries with Highest Infection Rate 
--compared to Population
SELECT Location,Population,
MAX(total_cases) AS HighestInfectionCount,
MAX((total_cases/population)) * 100 AS 
PercentPopulationInfected
FROM CovidDeaths$ 
--WHERE location LIKE '%India%' 
WHERE continent is not null
GROUP BY Location,Population
ORDER BY 1,2;

SELECT Location,Population,
MAX(total_cases) AS HighestInfectionCount,
MAX((total_cases/population)) * 100 AS 
PercentPopulationInfected
FROM CovidDeaths$ 
--WHERE location LIKE '%India%' 
GROUP BY Location,Population
ORDER BY 4 DESC;

--Showing countries with Highest Death Count per Population
--Converting nvarchar to INT using cast
SELECT Location,MAX(cast(Total_deaths as INT)) as TotalDeathCount
FROM CovidDeaths$ 
--WHERE location LIKE '%India%'
WHERE continent is not null
GROUP BY Location
ORDER BY 2 DESC;

--Let's break things down by continent

--Showing continents with the highest death count per population
SELECT continent,MAX(cast(Total_deaths as INT)) as TotalDeathCount
FROM CovidDeaths$
--WHERE location LIKE '%India%'
WHERE continent is not null
GROUP BY continent
ORDER BY 2 DESC;

