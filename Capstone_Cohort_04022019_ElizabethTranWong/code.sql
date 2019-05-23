Question 1
SELECT COUNT(distinct utm_campaign) as campaigns
FROM page_visits;

SELECT COUNT(distinct utm_source) as source
FROM page_visits;

SELECT utm_campaign as campaign
   utm_source as source
   COUNT(*) as page_visits
 FROM page_visits
 GROUP BY 1, 2
 ORDER BY 3 DESC;

Question 2
SELECT distinct page_name
FROM page_visits;

Question 3
WITH first_touch AS
 (SELECT user_id,
  MIN(timestamp) as first_touch_at 
FROM page_visits
GROUP BY user_id),  

 ft_attr AS
 (SELECT ft.user_id,
    ft.first_touch_at, 
    pv.utm_campaign, 
    pv.utm_source, 
    pv.page_name
  FROM first_touch ft
  JOIN page_visits pv ON 
    ft.user_id = pv.user_id AND 
    ft.first_touch_at = pv.timestamp)

SELECT utm_campaign,
   utm_source,
   COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

Question 4
WITH last_touch AS
   (SELECT user_id,
    MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
 
 lt_attr AS
  (SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_campaign,
    pv.utm_source
   FROM last_touch lt
   JOIN page_visits pv ON
     lt.user_id = pv.user_id AND
     lt.last_touch_at = pv.timestamp)

SELECT utm_campaign,
   utm_source,
   COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

Question 5
SELECT page_name, COUNT(*)
FROM page_visits
WHERE page_name = '4 - purchase';

Question 6
WITH last_touch AS
  (SELECT user_id,	
    MAX(timestamp) as 'last_touch_at'	
   FROM page_visits 	
   WHERE page_name = '4 - purchase'	
   GROUP BY user_id),    

 lt_attr AS  
   (SELECT lt.user_id,  
    lt.last_touch_at,  
    pv.utm_campaign, 
    pv.utm_source  
 FROM last_touch as 'lt'  
 JOIN page_visits as 'pv'  
 ON lt.user_id = pv.user_id   
 AND lt.last_touch_at = pv.timestamp)    

SELECT lt_attr.utm_campaign,   
   lt_attr.utm_source,  
   COUNT(*)  
FROM lt_attr  
GROUP BY 1, 2  
ORDER BY 3 DESC;








