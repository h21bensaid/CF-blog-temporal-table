CREATE PROCEDURE [dbo].[LoanHistoryDelete] (@Id int)
AS
BEGIN
    DECLARE @sql VARCHAR(MAX)

    BEGIN TRANSACTION

        ALTER TABLE [dbo].[LoanData] SET ( SYSTEM_VERSIONING = OFF )

        SET @sql = 'DELETE FROM [dbo].[LoanDataHistory] WITH (TABLOCKX) 
        WHERE [LoanNumber] = ''' + CAST(@Id AS VARCHAR(40)) + ''''
        EXEC (@sql)

        ALTER TABLE [dbo].[LoanData] SET ( SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[LoanDataHistory]))

    COMMIT TRANSACTION
END

GO 

DECLARE @loannumber INT
SET @loannumber = 2

EXEC [dbo].[LoanHistoryDelete] @loannumber

GO 

SELECT * FROM [dbo].[LoanData]
SELECT * FROM [dbo].[LoanDataHistory]
