SELECT bankname, security 
FROM banks
WHERE noaccounts>9000;

SELECT robberid 
FROM robbers
WHERE  nickname = 'Calamity Jane';


SELECT bankname 
FROM hasaccounts
WHERE  robberid = 9;
 

SELECT bankname, city, noaccounts
FROM banks
WHERE  bankname != 'Chicago'
ORDER BY noaccounts;

SELECT bankname, city
FROM robberies
order by date limit 1;

SELECT a.RobberId, r.Nickname, 
SUM(a.Share) 
AS Earnings 
FROM ACCOMPLICES a, ROBBERS r 
WHERE r.RobberId=a.RobberId 
GROUP BY a.RobberId, r.Nickname 
HAVING SUM(a.Share)>30000 
ORDER BY sum(a.Share) DESC;

SELECT s.Description, h.RobberId, r.Nickname 
FROM HAS_SKILLS h, SKILLS s, ROBBERS r 
WHERE h.SkillId=s.SkillId 
AND h.RobberId=r.RobberId 
ORDER BY s.Description;


SELECT RobberId, Nickname, NoYears 
FROM ROBBERS 
WHERE NoYears > 3;


SELECT RobberId, Nickname, (Age - NoYears) 
AS YearsOutOfPrision 
FROM ROBBERS 
WHERE NoYears > Age/2;
