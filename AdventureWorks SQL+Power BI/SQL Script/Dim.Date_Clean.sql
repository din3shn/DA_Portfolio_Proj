-- Clean Dim.Date
SELECT [DateKey],
       [FullDateAlternateKey] as Date,
       --    ,[DayNumberOfWeek]
       [EnglishDayNameOfWeek] as Day_Name,
       --    ,[SpanishDayNameOfWeek]
       --    ,[FrenchDayNameOfWeek]
       --    ,[DayNumberOfMonth]
       --    ,[DayNumberOfYear]
       [WeekNumberOfYear] as Week,
       [EnglishMonthName] as Month_Name,
       LEFT([EnglishMonthName], 3) as Month_Short,
       --    ,[SpanishMonthName]
       --    ,[FrenchMonthName]
       [MonthNumberOfYear] as Month,
       [CalendarQuarter] as Qtr,
       [CalendarYear] as Year
--    ,[CalendarSemester]
--    ,[FiscalQuarter]
--    ,[FiscalYear]
--    ,[FiscalSemester]
FROM [AdventureWorksDW2022].[dbo].[DimDate]
where LEFT(DateKey,4) >= YEAR(Getdate()) - 2;