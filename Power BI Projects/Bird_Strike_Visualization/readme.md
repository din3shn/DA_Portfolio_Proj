# Bird Strike Data Visualization

## Introduction

A bird strike is strictly defined as a collision between a bird and an aircraft which is in flight or on a take-off or landing roll. <br>
The term is often expanded to cover other wildlife strikes - with bats or ground animals. <br>
Bird Strike is common and can be a significant threat to aircraft safety. <br>
For smaller aircraft, significant damage may be caused to the aircraft structure and all aircraft, especially jet-engine ones, are vulnerable to the loss of thrust which can follow the ingestion of birds into engine air intakes. This has resulted in several fatal accidents.<br>
Bird strikes may occur during any phase of flight, but are most likely during the take-off, initial climb, approach and landing phases due to the greater numbers of birds in flight at lower levels. <br>
To have a closer look the following document visually depicts the data collected on Bird Strikes by FAA between 2000-2011.

## Dataset and Data Model

The Dataset was given in CSV format. The file was validated using excel and then saved as xlsx. The the files were imported to Power BI for further Data Transformation in Power Query and Power BI external tools.

![image](https://github.com/din3shn/DA_Portfolio_Proj/assets/160537914/6178659d-5965-4b2b-937b-393a38c63533)

## KPI Overview

The KPIs were created as Calculated Measures using DAX Functions. Then they were added to a Card to create KPI cards.

<img src= "https://github.com/din3shn/DA_Portfolio_Proj/assets/160537914/aedec435-71a1-412e-bcb9-a9fc6c266b91" width="800" height="500">

## Dashboard Overview

![image](https://github.com/din3shn/DA_Portfolio_Proj/assets/160537914/3a49cd9b-fa67-4db8-9ad5-00fc0b76db0c)

## Key Findings
- Total Strikes and Cost: There have been a total of 25.4K bird strikes reported, resulting in a total cost of $141.5M.
- Trends in Strikes: The number of bird strikes has generally increased over the years, with noticeable peaks in 2007 and 2011.
- Impact on Flights: A significant portion of bird strikes, specifically 25.8% (6,545 strikes), caused no damage to the aircraft. However, a notable percentage of strikes led to precautionary landings (2,939 strikes).
- Most Affected Airlines and Airports: The airline with the highest number of strikes has incurred substantial costs, and several airports have been identified as frequent sites of bird strikes. The top airport for strikes is listed with 291 affected.
- Wildlife Loss and Species: A total of 68.6K wildlife have been lost due to bird strikes, with 345 different wildlife species involved. Certain species like Unknown Bird (4.2K) and Mourning Dove (3.1K) are more frequently involved in strikes.
- Cost Breakdown: The total cost associated with bird strikes is $58.93M, with an average cost of $5,426 per strike. The costs are divided almost equally between small aircraft ($29.6M) and large aircraft ($29.3M).
- States and Aircraft Models: Florida, New York, and New Jersey are among the states with the highest number of bird strikes. Aircraft models such as B-737-700 and B-737-300 are frequently involved in bird strikes.
- Sky Conditions and Flight Phases: Most bird strikes occur during the approach phase of flight (10,062 strikes) and in clear sky conditions (15,959 strikes).
