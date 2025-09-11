CREATE TABLE Sales.EmployeeLogs (
  LogID INT IDENTITY(1,1) PRIMARY KEY,
  EmployeeID INT,
  LogMessage VARCHAR(255),
  LogDate DATE
)

CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT 
AS
BEGIN
  INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
  SELECT
    EmployeeID,
    'New Employee Added = ' + CAST(EmployeeID AS VARCHAR),
    GETDATE()
  FROM INSERTED
END
