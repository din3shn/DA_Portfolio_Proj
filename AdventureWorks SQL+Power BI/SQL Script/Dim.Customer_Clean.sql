-- Clean Dim_Customer Table
SELECT 
  [CustomerKey], 
  dc.[GeographyKey], 
  [CustomerAlternateKey], 
  --     ,[Title]
  [FirstName], 
  --     ,[MiddleName]
  [LastName], 
  CONCAT(FirstName, ' ', LastName) as FullName, 
  --     ,[NameStyle]
  --    ,[BirthDate]
  --     ,[MaritalStatus]
  --     ,[Suffix]
  case when [Gender] = 'M' then 'Male' when [Gender] = 'F' then 'Female' end as Gender, 
  --     ,[EmailAddress]
  --     ,[YearlyIncome]
  --     ,[TotalChildren]
  --     ,[NumberChildrenAtHome]
  --     ,[EnglishEducation]
  --     ,[SpanishEducation]
  --     ,[FrenchEducation]
  --     ,[EnglishOccupation]
  --     ,[SpanishOccupation]
  --    ,[FrenchOccupation]
  --     ,[HouseOwnerFlag]
  --     ,[NumberCarsOwned]
  --    ,[AddressLine1]
  --    ,[AddressLine2]
  --    ,[Phone]
  [DateFirstPurchase], 
  dg.City as City, 
  dg.StateProvinceName as State, 
  dg.EnglishCountryRegionName as Country
  --    ,[CommuteDistance]
FROM 
  [AdventureWorksDW2022].[dbo].[DimCustomer] dc 
  left join DimGeography dg on dg.GeographyKey = dc.GeographyKey 
order by 
  CustomerKey asc;
