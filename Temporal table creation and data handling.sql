--Creating the current table with system versioning automatically creates a historical table
CREATE TABLE [dbo].[LoanData]   
(    
--a PRIMARY KEY is required on the current table and not allowed on historical table
     [LoanNumber] INT IDENTITY PRIMARY KEY
    ,[CustomerID] NVARCHAR(6)
    ,[Stage] NVARCHAR(40)
    ,[LoanOfficerID] NVARCHAR(5)
    ,[UnderwritterID] NVARCHAR(5)
    ,[ProcessorID] NVARCHAR(5)
    ,[DateSubmitted] DATETIME
    ,[DateReviewed] DATETIME
    ,[DateProcessed] DATETIME
    ,[DateUnderwritten] DATETIME
    ,[DateSetteled] DATETIME
    ,[LoanAmount] MONEY 
--two DATETIME2 type start time and end time columns are required in order to log 
--the time modifications occur.
    ,[SysStartTime] DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL
    ,[SysEndTime] DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL
--The two columns are assigned as the system versioning period columns
    ,PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)     
)
--The following statement creates/assigns the historical table.
--It is preferable to name the table otherwise an [ugly] system generated name will be assigned 
WITH 
( 
    SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.LoanDataHistory)   
)

GO
--Adding new data to the temporal table
INSERT INTO [dbo].[LoanData] ([CustomerID],[Stage],[LoanOfficerID],[UnderwritterID],[ProcessorID],[DateSubmitted],[DateReviewed],[DateProcessed],[DateUnderwritten],[DateSetteled],[LoanAmount])	
VALUES ('055123','Processed', '01193', '02044', '03019','2020-11-25','2020-11-28','2020-12-05',NULL,NULL,549000)
, ('049034','Submitted', '01125', '02014', '03019','2020-12-05',NULL,NULL,NULL,NULL,319000)

GO

SELECT * FROM [dbo].[LoanData]
SELECT * FROM [dbo].[LoanDataHistory] 

GO

--Updating and deleting rows from the temporal table
UPDATE [dbo].[LoanData] SET DateUnderwritten = '2020-12-08', Stage = 'Underwritten' WHERE LoanNumber = 1
DELETE FROM [dbo].[LoanData] WHERE LoanNumber = 2

GO 

SELECT * FROM [dbo].[LoanData]
SELECT * FROM [dbo].[LoanDataHistory]
