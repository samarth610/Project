SELECT 
    Athlete_Name, 
    Team, 
    Sport, 
    SUM(Medal_Score) AS Career_Points
FROM athletes_cleaned
GROUP BY Athlete_Name, Team, Sport
ORDER BY Career_Points DESC
LIMIT 25;
---------------------------------------------------------------------------------------------------
SELECT 
    Team, 
    SUM(Medal_Score) AS Total_Weighted_Points,
    COUNT(Medal) AS Total_Medals
FROM athletes_cleaned
WHERE Medal != 'No Medal'
GROUP BY Team
ORDER BY Total_Weighted_Points DESC
LIMIT 100;
----------------------------------------------------------------------------------------------------------------
WITH Yearly_Athletes AS (
    SELECT 
        Year, 
        COUNT(DISTINCT Athlete_Name) AS Total_Athletes
    FROM athletes_cleaned
    GROUP BY Year
)
SELECT 
    Year, 
    Total_Athletes,
    -- Get the value from the previous year row
    LAG(Total_Athletes) OVER (ORDER BY Year) AS Previous_Year_Athletes,
    -- Calculate the numerical difference (useful for Waterfall Charts)
    (Total_Athletes - LAG(Total_Athletes) OVER (ORDER BY Year)) AS Net_Change,
    -- Calculate percentage growth
    ROUND(((Total_Athletes - LAG(Total_Athletes) OVER (ORDER BY Year)) * 100.0 / 
           NULLIF(LAG(Total_Athletes) OVER (ORDER BY Year), 0)), 2) AS Percent_Growth
FROM Yearly_Athletes
ORDER BY Year ASC;
-----------------------------------------------------------------------------------------------------
SELECT 
    Season, 
    SUM(Medal_Score) AS Total_Weighted_Points, 
    COUNT(ID) AS Athlete_Count
FROM athletes_cleaned
GROUP BY Season;
------------------------------------------------------------------------------------------------------------------------
SELECT 
    Sport, 
    ROUND(AVG(Age), 1) AS Average_Age
FROM athletes_cleaned
WHERE Age > 0
GROUP BY Sport
ORDER BY Average_Age DESC;
------------------------------------------------------------------------------------------------------------------
SELECT 
    Sport, 
    COUNT(DISTINCT Athlete_Name) AS Total_Unique_Athletes,
    COUNT(ID) AS Total_Event_Entries
FROM athletes_cleaned
GROUP BY Sport
ORDER BY Total_Unique_Athletes DESC;