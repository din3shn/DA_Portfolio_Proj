-- Dim.Product Clean
SELECT
    [ProductKey],
    [ProductAlternateKey] as Item_Code,
    --,[ProductSubcategoryKey]
    --,[WeightUnitMeasureCode] 
    --,[SizeUnitMeasureCode]
    [EnglishProductName],
    sc.EnglishProductSubcategoryName as SubCategory,
    pc.EnglishProductCategoryName    as Category,
    --,[SpanishProductName]
    --,[FrenchProductName]
    --,[StandardCost]
    --,[FinishedGoodsFlag]
    [Color] as Prod_Color,
    --,[SafetyStockLevel]
    --,[ReorderPoint]
    --,[ListPrice]
    [Size] as Prod_Size,
    --,[SizeRange]
    --,[Weight]
    --,[DaysToManufacture]
    [ProductLine] as Product_Line,
    --,[DealerPrice]
    --,[Class]
    --,[Style]
    [ModelName]                      as Prod_ModelName,
    --,[LargePhoto]
    [EnglishDescription]             as Prod_Description,
    --,[FrenchDescription]
    --,[ChineseDescription]
    --,[ArabicDescription]
    --,[HebrewDescription]
    --,[ThaiDescription]
    --,[GermanDescription]
    --,[JapaneseDescription]
    --,[TurkishDescription]
    --,[StartDate]
    --,[EndDate]
    isnull([Status], 'Outdated') as Prod_Status
FROM
    [AdventureWorksDW2022].[dbo].[DimProduct] p
    left join
        DimProductSubcategory sc
            on sc.ProductSubcategoryKey = p.ProductSubcategoryKey
    left join
        DimProductCategory pc
            on pc.ProductCategoryKey = sc.ProductCategoryKey
order by
    ProductKey asc;