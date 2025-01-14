--- Discover the data 

Select *
from spotify_history
                                                                                         
---Modfiey the Skipped column 

Update  spotify_history 
Set  Skipped  = 0 
where Skipped is NULL

---Modfiey the reason_start column 

Update  spotify_history 
Set  reason_start  = 'unknown'
where reason_start is NULL


======================

--- KPI

--- The number of songs 

Select COUNT(DISTINCT(track_Name)) AS Songs_Number
From  spotify_history

--- The Skipping Rate 

Select CONCAT(Sum(Skipped)*100 /Count(Skipped) ,'%')as Skip_Rate 
From  spotify_history


--- THe Minutes Played
     
Select ROUND(SUM(M_Played),2) AS Minutes_Played
From  spotify_history

--- Shuffle Numbers

Select Count(Shuffle) as Shuffle_Times
From  spotify_history

--- Most Year listend to music 

Select TOP 1 P_Year , SUM([P_Hour]) Hours
From  spotify_history
Group BY  P_Year

=========================================== 

--- TOP 5 Tracks played

select TOP 5 track_name ,
COUNT(track_name) as Times_Played , 
Round(sum(M_played),2) as Minutes_played
from spotify_history
group by track_name
ORDER BY Times_Played DESC

=========================================== 

--- Top 10 Artists have trackes played 

SELECT TOP 10 artist_name , COUNT(track_name) AS SongsPlayed
FROM spotify_history
group by artist_name
ORDER BY COUNT(track_name) DESC

=========================================== 

--- Top 5 Artists have Time played 

SELECT TOP 5 Artist_name , Sum(P_Hour) AS Time_Played
FROM spotify_history 
GROUP BY Artist_name 
ORDER BY Time_Played DESC

=========================================== 

--- Number of tracks that didn't play except one time 

select SUM(ONETIME_Played) AS ONETIME_Played
from (
SELECT COUNT(track_name) AS ONETIME_Played
FROM spotify_history
GROUP BY track_name
HAVING COUNT(track_name) = 1) AS Track  

===========================================

--- Top 5  album had the most playtime

SELECT TOP 5 album_name , SUM(P_Hour) AS Album_PlayTime
FROM spotify_history
group by album_name
ORDER BY SUM(P_Hour) DESC

=====================================

---  TOP 5 Tracks in top 5 album had the most playtime

SELECT TOP 1 track_name , SUM(P_Hour) AS track_PlayTime
FROM spotify_history

where Album_name in ( SELECT TOP 5 album_name 
FROM spotify_history 
group by album_name 
ORDER BY SUM(P_Hour) DESC)

GROUP BY track_name
ORDER BY SUM(P_Hour) DESC

=================================================

--- Average playtime of tracks of TOP 5 each album 

SELECT TOP 5 album_name , ROUND(AVG(P_Hour),2) AS Album_PlayTime
FROM spotify_history
group by album_name
ORDER BY AVG(P_Hour) DESC

=================================================

--- TOTAL time played for the top Played albums 

SELECT TOP 1 album_name, ROUND(Sum(M_Played), 2) AS Album_PlayTime
FROM spotify_history
GROUP BY album_name
ORDER BY COUNT(album_name)DESC

=================================================

--- Albums with the most skipped tracks

SELECT TOP 5 album_name, SUM(Skipped) AS Skipped_Number
FROM spotify_history
GROUP BY album_name
ORDER BY SUM(Skipped) desc


================================================

--- THE AVERAGE Time played in diffrent Reasons             
SELECT TOP 1 
reason_start,
reason_end, 
ROUND(AVG(M_Played),2)  AS Average_time ,
COUNT(*) AS Tracks_NUM
FROM spotify_history
where NOT reason_end = 'unknown' and reason_end is not null  and NOT reason_start = 'unknown'
GROUP BY reason_start, reason_end
ORDER BY Tracks_NUM DESC

============================================

--- The diffrence between Platforms

SELECT Platform, ROUND(SUM(M_Played),2) AS Minuets_Played ,COUNT(Platform) AS Tracks_NUM
from spotify_history
GROUP BY Platform
ORDER BY Minuets_Played

===========================================

--- Top Platforms listend to 

SELECT TOP 1 Platform, ROUND(SUM(M_Played),2) AS Minuets_Played ,COUNT(Platform) AS Tracks_NUM 
from spotify_history
GROUP BY Platform
ORDER BY Minuets_Played  DESC

===========================================

--- Years Songs

SELECT P_Year, ROUND(SUM(M_Played),2) AS Minuets_Played ,COUNT(Platform) AS Tracks_NUM
from spotify_history
GROUP BY P_Year
ORDER BY Tracks_NUM DESC

============================================

--- Best hours to listen

SELECT TOP 1 P_Hour, ROUND(SUM(M_Played),2) AS Minuets_Played 
from spotify_history
GROUP BY P_Hour
ORDER BY Minuets_Played DESC

============================================

--- Week Music

SELECT DayName, ROUND(SUM(M_Played),2) AS WEEK_TimePLayed
from spotify_history
GROUP BY DayName
ORDER BY WEEK_TimePLayed DESC

===============================================
--- Most month listened 
SELECT TOP 1 P_Month, ROUND(SUM(M_Played),2) AS MonthListened_Time 
from spotify_history
GROUP BY P_Month    
ORDER BY  MonthListened_Time DESC

