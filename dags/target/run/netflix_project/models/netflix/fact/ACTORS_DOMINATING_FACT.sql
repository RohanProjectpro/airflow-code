
  
    

        create or replace transient table PROD.DBT_PROD.ACTORS_DOMINATING_FACT
         as
        (



WITH ACTORS AS
(
    SELECT 
    ID
    ,NAME
    FROM PROD.DBT_TRANSFORM.CREDITS_DIM
    WHERE ROLE='ACTOR'
)

SELECT
REPLACE(REPLACE(UPPER(GENRES),'[',''),']','') AS GENRES
,ACTORS.NAME
,SUM(CASE WHEN GENRES IS NOT NULL THEN 1 ELSE 0 END) AS PERFORMANCES 
FROM PROD.DBT_TRANSFORM.SHOW_DETAILS_DIM AS SD
LEFT JOIN
ACTORS
ON SD.ID=ACTORS.ID
WHERE NAME IS NOT NULL
GROUP BY 1,2
        );
      
  