-- Datenbank View für die Journal Datenbank
-- 

-- --------------------------------------------------------

--
-- Auflistung aller Buchungen in einer Spalte
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewEntries
AS SELECT
  *
FROM (SELECT
    j.entryID,
    j.date,
    j.recipient,
    j.entryText,
    j.grandTotal,
    j.debitAccount AS accountID,
    j.period,
    'debit' AS EntrySide
  FROM journal j

  UNION ALL

  SELECT
    j.entryID,
    j.date,
    j.recipient,
    j.entryText,
    -j.grandTotal,
    j.creditAccount AS accountID,
    j.period,
    'credit' AS EntrySide
  FROM journal j) e
ORDER BY e.date ASC,
  e.entryID ASC