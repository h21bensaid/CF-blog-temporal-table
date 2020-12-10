CREATE TABLE dbo.PropertyDetails (    
       LoanNumber INT NOT NULL PRIMARY KEY CLUSTERED  
     , PropertyType NVARCHAR(50) NOT NULL  
     , [Address] NVARCHAR(255) NOT NULL
     , [Address2] NVARCHAR(255) NULL
     , CityName Nvarchar(50) NOT NULL
     , [State] Nvarchar(2) NOT NULL
     , ZipCode Nvarchar(5) NOT NULL
     , ZipExtension Nvarchar(4) NULL
	 )
GO

INSERT INTO dbo.PropertyDetails (LoanNumber, PropertyType, [Address], [Address2], CityName, [State], ZipCode, ZipExtension )
VALUES ( 1,'single family - detached','123, Main street',NULL,'Hillwood','CA','55555',NULL)
,(2,'apartment','456, 1st street',NULL,'Tempoville','WA','77777','4321')

GO

ALTER TABLE dbo.PropertyDetails
ADD SysStartTime datetime2 GENERATED ALWAYS AS ROW START  
DEFAULT SYSUTCDATETIME() NOT NULL
,SysEndTime datetime2 GENERATED ALWAYS AS ROW END 
DEFAULT CONVERT (DATETIME2, '9999-12-31 23:59:59.9999999') NOT NULL
,PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)

GO
   
ALTER TABLE dbo.PropertyDetails
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.PropertyDetailsHistory))

GO

SELECT * FROM dbo.PropertyDetails 
SELECT * FROM dbo.PropertyDetailsHistory
