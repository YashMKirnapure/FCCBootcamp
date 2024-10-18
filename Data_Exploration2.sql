-- Global Numbers --
SELECT date,total_cases ,total_deaths,
(total_deaths/total_cases) * 100 as DeathPercentage
FROM CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2;

SELECT date,SUM(new_cases)
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

SELECT date,SUM(CAST(new_deaths as INT))
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

SELECT date,SUM(new_cases) as total_cases,
SUM(CAST(new_deaths as INT)) as total_deaths,
SUM(CAST(new_deaths as INT))/SUM(new_cases)*100 as DeathPercentage
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Looking at Total Population vs Vaccinations
SELECT * FROM CovidDeaths$ CD JOIN CovidVaccinations$ CV 
ON CD.location = CV.location AND CD.date = CV.date;

SELECT CD.continent,CD.location,CD.date,CD.population,CV.new_vaccinations
FROM CovidDeaths$ CD JOIN CovidVaccinations$ CV 
ON CD.location = CV.location AND CD.date = CV.date 
WHERE CD.continent IS NOT NULL
ORDER BY 2,3;

SELECT CD.continent,CD.location,CD.date,CD.population
,CV.new_vaccinations,SUM(CONVERT(int,CV.new_vaccinations))
OVER (Partition By CD.location) FROM CovidDeaths$ CD
JOIN CovidVaccinations$ CV ON CD.location = CV.location
AND CD.date = CV.date WHERE CD.continent IS NOT NULL
ORDER BY 2,3;

SELECT CD.continent,CD.location,CD.date,CD.population
,CV.new_vaccinations,SUM(CONVERT(int,CV.new_vaccinations))
OVER (Partition By CD.location ORDER BY CD.location ,CD.Date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ CD
JOIN CovidVaccinations$ CV ON CD.location = CV.location
AND CD.date = CV.date WHERE CD.continent IS NOT NULL
ORDER BY 2,3;

--USE CTE
WITH PopvsVac 
(Continent,Location,Date,Population,New_Vaccinations,RollingPeopleVaccinated)
AS
(
SELECT CD.continent,CD.location,CD.date,CD.population
,CV.new_vaccinations,SUM(CONVERT(int,CV.new_vaccinations))
OVER (Partition By CD.location ORDER BY CD.location ,CD.Date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ CD
JOIN CovidVaccinations$ CV ON CD.location = CV.location
AND CD.date = CV.date WHERE CD.continent IS NOT NULL
--ORDER BY 2,3
)

SELECT *, (RollingPeopleVaccinated/Population) * 100 FROM PopvsVac;

--USE TEMP Table

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT CD.continent,CD.location,CD.date,CD.population
,CV.new_vaccinations,SUM(CONVERT(int,CV.new_vaccinations))
OVER (Partition By CD.location ORDER BY CD.location ,CD.Date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ CD
JOIN CovidVaccinations$ CV ON CD.location = CV.location
AND CD.date = CV.date WHERE CD.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population) * 100 
FROM #PercentPopulationVaccinated;

--Creating VIEW to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT CD.continent,CD.location,CD.date,CD.population
,CV.new_vaccinations,SUM(CONVERT(int,CV.new_vaccinations))
OVER (Partition By CD.location ORDER BY CD.location ,CD.Date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ CD
JOIN CovidVaccinations$ CV ON CD.location = CV.location
AND CD.date = CV.date WHERE CD.continent IS NOT NULL
--ORDER BY 2,3

SELECT * FROM PercentPopulationVaccinated;






