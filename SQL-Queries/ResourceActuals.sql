--Returns the tasks actuals of a project by resource

SELECT DISTINCT
  UNIT.NAME DEPARTMENT,
  RES.FULL_NAME "Name",
  SUM(ASSIGN.PRACTSUM / 3600) ACTUALS
FROM INV_INVESTMENTS INV
  INNER JOIN PRTEAM TEAM
    ON INV.ID = TEAM.PRPROJECTID
  INNER JOIN SRM_RESOURCES RES
    ON TEAM.PRRESOURCEID = RES.ID
  INNER JOIN PRASSIGNMENT ASSIGN
    ON ASSIGN.PRRESOURCEID = RES.ID
  INNER JOIN PRTASK TASK
    ON ASSIGN.PRTASKID = TASK.PRID
  INNER JOIN ODF_CA_TASK OTASK
    ON OTASK.ID = TASK.PRID
  INNER JOIN 	PRJ_OBS_ASSOCIATIONS ASSOC
    ON 		RES.ID = ASSOC.RECORD_ID
  INNER JOIN 	PRJ_OBS_UNITS UNIT
    ON 		UNIT.ID = ASSOC.UNIT_ID
  INNER JOIN 	PRJ_OBS_TYPES OTYPES
    ON 		(UNIT.TYPE_ID = OTYPES.ID 
    AND 	OTYPES.NAME = 'Corporate Department OBS')
WHERE INV.CODE = 'PR1002' --Type any project code
AND RES.PERSON_TYPE > 0
  AND TASK.PRSTART BETWEEN '01-JAN-2015' AND '31-DEC-2016' --Change it accordingly to the period you want
GROUP BY UNIT.NAME,
      RES.FULL_NAME
HAVING SUM(ASSIGN.PRACTSUM / 3600) > 0
