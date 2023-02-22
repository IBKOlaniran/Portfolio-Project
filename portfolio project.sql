
select location, population, total_deaths
from PortfolioProject..[covids deaths]
where continent is not null
order by 1


--select *
--from PortfolioProject..[covid vaccination]
where continent is not null
--order by 3, 4


select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..[covids deaths]
where continent is not null
order by 1, 2


select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..[covids deaths]
where continent is not null
where location like '%Nigeria%'
order by 1, 2

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..[covids deaths]
--where location like '%Nigeria%'
order by 1, 2


select location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopuationInfected
from PortfolioProject..[covids deaths]
--where location like '%Nigeria%'
group by location, population
order by PercentPopuationInfected desc


select location, MAX(cast(total_deaths as int)) as TotalDeathCount 
from PortfolioProject..[covids deaths]
--where location like '%Nigeria%'
where continent is not null
group by location


select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
from PortfolioProject..[covids deaths]
--where location like '%Nigeria%'
where continent is not null
group by continent
order by TotalDeathCount desc



select SUM (new_cases)as total_cases, sum (cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..[covids deaths]
where continent is not null
--where location like '%Nigeria%'
--group by date
order by 1, 2



select date, SUM (new_cases)as total_cases, sum (cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..[covids deaths]
where continent is not null
--where location like '%Nigeria%'
group by date
order by 1, 2

with popvsvac (continent, location, date, population, total_vaccination, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations
, sum(convert(int,vac.total_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
from PortfolioProject..[covids deaths] dea
join PortfolioProject..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *
from popvsvac

create view percentagepopulationvaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations
, sum(convert(int,vac.total_vaccinations)) over (partition by dea.location order by dea.location, 
dea.date) as rollingpeoplevaccinated
from PortfolioProject..[covids deaths] dea
join PortfolioProject..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


