--The DataSet used in this project has real life accuracy to the covid outbreak
--ALL THE DATASET IS IMPORTED USING SSMS IMPORT/EXPORT 
--MODULE TO EXTRACT DATA FROM EXCEL USING THE ODBC
--in the data the continent is null instead of asia and location is asia 
--So we will be uing not null in every query example: WHERE continent IS NOT NULL
SELECT * FROM [PortfolioProject].[dbo].[CovidDeaths]
order by 3,4


SELECT * FROM [PortfolioProject].[dbo].[CovidVaccinations]
order by 3,4

--finding total number of cases
SELECT location, SUM(total_cases) as Total_country_cases
FROM PortfolioProject.dbo.CovidDeaths
Group By location
Order BY location ASC


--Looking total number of cases vs total number of death
SELECT location, total_cases, total_deaths, CONVERT(numeric(10,2),(total_deaths/total_cases)*100) AS Death_Percent
FROM PortfolioProject..CovidDeaths


--Looking total number of cases vs total number of death
--Likelyhood of dying if you do not take actions for covid on time
SELECT location, total_cases, total_deaths, CONVERT(numeric(10,2),(total_deaths/total_cases)*100) AS Irresponsible_Death_Percent
FROM PortfolioProject..CovidDeaths
WHERE location like '%united states%'



--Lokking at cases vs population
SELECT location, total_cases, population, CONVERT(numeric(10,2),(total_cases/population)*100) AS Percentage_population_infected
FROM PortfolioProject..CovidDeaths
WHERE location like '%united states%'


--looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population)*100) AS Highest_Infection_Rate
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY Highest_Infection_Rate DESC


--looking at countries with highest death count compared to population
SELECT  location, population, MAX(CAST(total_deaths as int)) AS Sub_Total_Deaths
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Sub_Total_Deaths DESC