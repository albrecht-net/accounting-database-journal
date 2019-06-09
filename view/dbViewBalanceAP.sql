-- Datenbank View für die Journal Datenbank
-- 

-- --------------------------------------------------------

--
-- Aktueller Saldo der Aktiven, Passiven
-- Assets / Liabilities
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewBalanceAL
AS SELECT
  a.classID,
  a.classLabel,
  a.categoryID,
  a.categoryLabel,
  a.accountID,
  a.accountLabel,
  SUM(e.grandTotal) AS balance
FROM viewAccount a
  LEFT JOIN viewEntries e
    ON e.accountID = a.accountID
WHERE a.classID IN (1, 2)
GROUP BY a.accountID
ORDER BY a.accountID ASC