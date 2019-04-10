-- Datenbank View für die Benutzer-Zieldatenbank
-- Gültig ab: Accounting v2.0.0-beta
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
  e.entryID,
  e.created,
  e.date,
  recipient.recipientID AS recipientID,
  recipient.label AS recipient,
  e.invoiceNo,
  e.entryText,
  e.grandTotal,
  account.accountID AS accountID,
  account.label AS account,
  e.period,
  e.entrySide
FROM (SELECT
    j.entryID,
    j.created,
    j.date,
    j.recipient AS recipientID,
    j.invoiceNo,
    j.entryText,
    j.grandTotal,
    j.debitAccount AS accountID,
    j.period,
    'debit' AS entrySide
  FROM journal j

  UNION ALL

  SELECT
    j.entryID,
    j.created,
    j.date,
    j.recipient AS recipientID,
    j.invoiceNo,
    j.entryText,
    -j.grandTotal,
    j.creditAccount AS accountID,
    j.period,
    'credit' AS entrySide
  FROM journal j
) e
  LEFT JOIN recipient
    ON e.recipientID = recipient.recipientID
  LEFT JOIN account
    ON e.accountID = account.accountID
ORDER BY
  e.date ASC,
  e.created ASC