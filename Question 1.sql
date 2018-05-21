CREATE TABLE BANKS(   
BankName varchar(50) NOT NULL,   
City varchar(50) NOT NULL,   
NoAccounts integer NOT NULL DEFAULT 0 CONSTRAINT ValidNoofAccounts CHECK (NoAccounts >= 0),   
Security varchar(20) NOT NULL CONSTRAINT security CHECK (Security IN ('excellent', 'very good', 'good','weak')),  
CONSTRAINT bankpk PRIMARY KEY (BankName, City)
); 

CREATE TABLE ROBBERIES(    
BankName varchar(50) NOT NULL,    
City varchar(50) NOT NULL,    
Date date NOT NULL,    
Amount decimal(20,2) NOT NULL CONSTRAINT ValidAmount CHECK (Amount >= 0),    
CONSTRAINT robberiespk PRIMARY KEY (BankName, City, Date),    
CONSTRAINT robberiesfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE RESTRICT
);

CREATE TABLE PLANS(    
BankName varchar(50) NOT NULL,    
City varchar(50) NOT NULL,    
NoRobbers integer NOT NULL DEFAULT 0 CONSTRAINT ValidNoOfRobbers CHECK (NoRobbers >= 0),     
PlannedDate date NOT NULL,    CONSTRAINT planspk PRIMARY KEY (BankName, City, PlannedDate),    
CONSTRAINT plansfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE CASCADE
);

CREATE TABLE ROBBERS(    
RobberId serial PRIMARY KEY,    
Nickname varchar(50) NOT NULL,    
Age integer NOT NULL CONSTRAINT ValidAge CHECK (Age >= 0),     
NoYears integer NOT NULL CONSTRAINT ValidPrisonTime CHECK (NoYears <= Age AND NoYears >= 0)
);

CREATE TABLE SKILLS(    
SkillId serial PRIMARY KEY,    
Description text UNIQUE
);

CREATE TABLE HAS_SKILLS(    
RobberId integer NOT NULL,    
SkillId integer NOT NULL,    
Preference integer NOT NULL CONSTRAINT prefvalue CHECK (Preference BETWEEN 1 AND 3),    
Grade varchar(2) NOT NULL CONSTRAINT grades CHECK (Grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', NULL)),  
CONSTRAINT has_skillspk PRIMARY KEY (RobberId, SkillId),    
CONSTRAINT rhas_skillsfk FOREIGN KEY (RobberId) REFERENCES ROBBERS(RobberId) ON DELETE CASCADE,    
CONSTRAINT shas_skillsfk FOREIGN KEY (SkillId) REFERENCES SKILLS(SkillId) ON DELETE RESTRICT,    
UNIQUE (RobberId, Preference)
);

CREATE TABLE HASACCOUNTS(  
RobberId integer NOT NULL,  
BankName varchar(50) NOT NULL,  
City varchar(50) NOT NULL,  
CONSTRAINT hasaccountspk PRIMARY KEY (RobberId, BankName, City),  
CONSTRAINT bhasaccountsfk FOREIGN KEY (BankName, City) REFERENCES BANKS(BankName, City) ON DELETE CASCADE,  
CONSTRAINT rhasaccountsfk FOREIGN KEY (RobberId) REFERENCES ROBBERS(RobberId) ON DELETE CASCADE
);

CREATE TABLE ACCOMPLICES( 
RobberId integer NOT NULL, 
BankName varchar(50) NOT NULL, City varchar(50) NOT NULL, 
RobberyDate date NOT NULL, 
Share decimal(20,2) NOT NULL CONSTRAINT ValidShare CHECK (Share >= 0), 
CONSTRAINT accomplicespk PRIMARY KEY (RobberId, BankName, City, RobberyDate), 
CONSTRAINT baccomplicesfk FOREIGN KEY (BankName, City, RobberyDate) REFERENCES ROBBERIES(BankName, City, Date) ON DELETE CASCADE, 
CONSTRAINT raccomplicesfk FOREIGN KEY (RobberId) REFERENCES ROBBERS(RobberId) ON DELETE RESTRICT);
