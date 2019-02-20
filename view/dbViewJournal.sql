-- Datenbank View für die Benutzer-Zieldatenbank
-- Gültig ab: Accounting v2.0.0-beta
-- 

-- --------------------------------------------------------

--
-- Ausgabe der Einträge im Journal
--

CREATE
  ALGORITHM = UNDEFINED
  SQL SECURITY INVOKER
  VIEW viewJournal
AS SELECT
  j.entryID,
  j.created,
  j.date,
  recipient.label AS recipient,
  j.invoiceNo,
  j.entryText,
  j.grandTotal,
  debitAccount.accountID AS debitAccountID,
  debitAccount.label AS debitAccount,
  creditAccount.accountID AS creditAccountID,
  creditAccount.label AS creditAccount,
  period.label AS period,
  classification1.label AS classification1,
  classification2.label AS classification2,
  classification3.label AS classification3,
  j.entryReference,
  j.reconcilation
FROM journal j
  LEFT JOIN recipient
    ON j.recipient = recipient.recipientID
  LEFT JOIN account AS debitAccount
    ON j.debitAccount = debitAccount.accountID
  LEFT JOIN account AS creditAccount
    ON j.creditAccount = creditAccount.accountID
  LEFT JOIN period
    ON j.period = period.periodID
  LEFT JOIN classification AS classification1
    ON j.classification1 = classification1.classificationID
  LEFT JOIN classification AS classification2
    ON j.classification2 = classification2.classificationID
  LEFT JOIN classification AS classification3
    ON j.classification3 = classification3.classificationID