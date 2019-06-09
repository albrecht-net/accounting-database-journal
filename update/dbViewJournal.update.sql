-- Datenbank View Updates für die Journal Datenbank
-- Achtung: Die Updates sind nur für die angegebene Versionserhöhung gültig und sollten nach aufsteigener Versionsnummer ausgeführt werden!
-- Die hier verwendeten Versionsnummern beziehen sich auf die Journal Datenbank. Die Kompabilität zu Accounting muss mithilfe der Versionsübersicht sichergestellt werden.
--

-- --------------------------------------------------------

--
-- Update von v1.1.0 zu vx.x.x
--

CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewAccount AS SELECT accountClass.classID, accountClass.label AS classLabel, accountCategory.categoryID, accountCategory.label AS categoryLabel, account.accountID, account.label AS accountLabel, accountClass.sign AS classSign, account.active AS accountIsActive FROM account LEFT JOIN accountCategory ON account.category = accountCategory.categoryID LEFT JOIN accountClass ON accountCategory.class = accountClass.classID;
CREATE OR REPLACE ALGORITHM = UNDEFINED SQL SECURITY INVOKER VIEW viewBalanceAL AS SELECT a.classID, a.classLabel, a.categoryID, a.categoryLabel, a.accountID, a.accountLabel, SUM(e.grandTotal) AS balance, a.accountIsActive FROM viewAccount a LEFT JOIN viewEntries e ON e.accountID = a.accountID WHERE a.classID IN (1, 2) GROUP BY a.accountID ORDER BY a.accountID ASC;
