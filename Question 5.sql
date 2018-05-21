SELECT RobberId, Nickname 
FROM ROBBERS 
NATURAL JOIN(SELECT RobberId FROM ACCOMPLICES GROUP BY RobberId HAVING COUNT(RobberId)>((SELECT COUNT(RobberId) FROM ACCOMPLICES)/(SELECT COUNT(DISTINCT RobberId) FROM ACCOMPLICES))) 
AS Actives NATURAL JOIN (SELECT RobberId, SUM(Share) AS RobberEarnings 
FROM ACCOMPLICES GROUP BY RobberId) 
AS Earnings 
WHERE NoYears = 0 
ORDER BY RobberEarnings DESC;

SELECT Security, AVG(Amount) 
AS Amount, COUNT(Security) 
AS NoOfRobberies 
FROM(SELECT BankName, City, Amount, Security 
FROM Robberies NATURAL JOIN Banks) 
AS RobberiesPerSecurity GROUP BY Security;
 

SELECT DISTINCT Nickname, Security, Description 
FROM accomplices 
NATURAL JOIN robbers 
NATURAL JOIN banks 
NATURAL JOIN has_skills
NATURAL JOIN skills 
ORDER BY Security;

