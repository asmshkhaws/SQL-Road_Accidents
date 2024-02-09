Select *
From road_accident

------------------------------------------------------------------------------------------------------------------
--Total Casualties taken place CY
Select sum(number_of_casualties) as CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'

------------------------------------------------------------------------------------------------------------------
--Total Accidents taken place CY
Select Count(Distinct accident_index) as CY_Accidents
From road_accident
Where YEAR(accident_date) = '2022'

------------------------------------------------------------------------------------------------------------------
--Fatal Casualties taken place CY(2022)
Select Sum(number_of_casualties) as CY_Fatal_Casualties
From road_accident
Where YEAR(accident_date) = '2022' AND accident_severity = 'Fatal'

--Total % of Fatal Casualties taken place
Select Cast(Cast(Sum(number_of_casualties) As decimal (10,2))*100 
/ (Select Cast(Sum(number_of_casualties) As decimal (10,2)) from road_accident) as decimal(10,2)) as PCT
From road_accident
Where accident_severity = 'Fatal'

-------------
--Total Serious Casualties taken place CY(2022)
Select Sum(number_of_casualties) as CY_Serious_Casualties
From road_accident
Where YEAR(accident_date) = '2022' AND accident_severity = 'Serious'

--Total % of Serious Casualties taken place
Select Cast(Cast(Sum(number_of_casualties) As decimal (10,2))*100 
/ (Select Cast(Sum(number_of_casualties) As decimal (10,2)) from road_accident) as decimal(10,2)) as PCT
From road_accident
Where accident_severity = 'Serious'

--------------
--Total Slight Casualties taken place CY(2022)
Select Sum(number_of_casualties) as CY_Slight_Casualties
From road_accident
Where YEAR(accident_date) = '2022' AND accident_severity = 'Slight'

--Total % of Slight Casualties taken place
Select Cast(Cast(Sum(number_of_casualties) As decimal (10,2))*100 
/ (Select Cast(Sum(number_of_casualties) As decimal (10,2)) from road_accident) as decimal(10,2)) as PCT
From road_accident
Where accident_severity = 'Slight'

------------------------------------------------------------------------------------------------------------------
--Casualties by Vehicle_Type CY(2022)
--SELECT DISTINCT vehicle_type FROM road_accident ORDER BY vehicle_type;

Select
	CASE
		When vehicle_type in ('Agricultural vehicle') then 'Agricultural'
		When vehicle_type in ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') then 'Bus'
		When vehicle_type in ('Car', 'Taxi/Private hire car') then 'Car'
		When vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') then 'Bike'
		When vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') then 'Van'
		Else 'Other'
	End as vehicle_group,
	Sum(number_of_casualties) AS CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'
Group by
	CASE
		When vehicle_type in ('Agricultural vehicle') then 'Agricultural'
		When vehicle_type in ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') then 'Bus'
		When vehicle_type in ('Car', 'Taxi/Private hire car') then 'Car'
		When vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') then 'Bike'
		When vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') then 'Van'
		Else 'Other'
	End

------------------------------------------------------------------------------------------------------------------
-- Monthly Casualties in CY(2022)

Select DATENAME(Month, accident_date) as Month_Name, Sum(Number_of_casualties) AS CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'
Group by DATENAME(Month, accident_date)

-- Monthly Casualties in PY(2021)

Select DATENAME(Month, accident_date) as Month_Name, Sum(Number_of_casualties) AS PY_Casualties
From road_accident
Where YEAR(accident_date) = '2021'
Group by DATENAME(Month, accident_date)

------------------------------------------------------------------------------------------------------------------
-- Casualties by Road_Type in CY(2022)
Select road_type, Sum(number_of_casualties) as CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'
Group by road_type

------------------------------------------------------------------------------------------------------------------
-- % Casualties by Urban/Rural in CY(2022)
Select urban_or_rural_area, Cast(Cast(Sum(number_of_casualties) as decimal (10,2))*100
/(Select Cast(Sum(number_of_casualties)as decimal (10,2)) from road_accident) as decimal (10,2)) as CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'
Group by urban_or_rural_area

------------------------------------------------------------------------------------------------------------------
-- % Casualties by Light Condition in CY(2022)

--Select Distinct light_conditions from road_accident order by light_conditions

Select
	Case
		When light_conditions in ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') then 'Night'
		Else 'Day'
	End as light_condition,
	Cast(Cast(Sum(number_of_casualties) as decimal (10,2))*100
/(Select Cast(Sum(number_of_casualties)as decimal (10,2)) from road_accident Where YEAR(accident_date) = '2022') as decimal (10,2)) as CY_Casualties
From road_accident
Where YEAR(accident_date) = '2022'
Group by
	Case
		When light_conditions in ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') then 'Night'
		Else 'Day'
	End

------------------------------------------------------------------------------------------------------------------
--Top 10 Casualties by Location

Select Top 10 local_authority, Sum(number_of_casualties) as Total_Casualties
From road_accident
Group by local_authority
Order by Total_Casualties Desc